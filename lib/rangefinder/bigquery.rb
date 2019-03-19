require "google/cloud/bigquery"

class Rangefinder::Bigquery
  def initialize(options)
    $logger.info "Starting Bigquery connection"
    gcloud = options[:gcloud]

    raise "Required gCloud configuration missing" unless gcloud

    gcloud[:keyfile] = File.expand_path(gcloud[:keyfile])
    @bigquery = Google::Cloud::Bigquery.new(
      :project_id  => gcloud[:project],
      :credentials => Google::Cloud::Bigquery::Credentials.new(gcloud[:keyfile]),
    )
    @dataset = @bigquery.dataset(gcloud[:dataset])
    raise "\nThere is a problem with the gCloud configuration: \n #{JSON.pretty_generate(options)}" if @dataset.nil?
  end

  def find(namespace, kind, name)
    sql = "SELECT DISTINCT module, i.source, m.source AS repo
           FROM `bto-dataops-datalake-prod.community.forge_itemized` AS i
           JOIN `bto-dataops-datalake-prod.community.forge_modules` AS m
             ON m.slug = i.module
           WHERE kind = @kind AND element = @name"

    data = @dataset.query(sql, params: {kind: kind.to_s, name: name})

    if namespace
      exact, near = data.partition {|row| row[:source] == namespace}
      puppetfile  = "#{puppetfile_count(namespace)} of #{puppetfile_count}"
    else
      exact      = nil
      puppetfile = nil
      near       = data
    end

    {
      :kind       => kind,
      :name       => name,
      :exact      => exact,
      :near       => near,
      :puppetfile => puppetfile,
    }
  end

  def puppetfile_count(modname=nil)
    if modname
      sql = 'SELECT COUNT(DISTINCT repo_name) AS count
             FROM `bto-dataops-datalake-prod.community.github_puppetfile_usage`
             WHERE module = @name'

      data = @dataset.query(sql, params: {name: modname})
    else
      sql = 'SELECT COUNT(DISTINCT repo_name) AS count
             FROM `bto-dataops-datalake-prod.community.github_puppetfile_usage`'

      data = @dataset.query(sql)
    end
    data.first[:count]
  end

end
