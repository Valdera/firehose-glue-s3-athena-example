resource "aws_glue_catalog_database" "analytics_database" {
  name = "user-analytics-db"
}

resource "aws_glue_catalog_table" "user_events_table" {
  name          = "user-events"
  database_name = aws_glue_catalog_database.analytics_database.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification"   = "parquet",
  }

  partition_keys {
    name = "year"
    type = "string"
  }

  partition_keys {
    name = "month"
    type = "string"
  }

  partition_keys {
    name = "day"
    type = "string"
  }

  storage_descriptor {
    columns {
      name = "user_id"
      type = "string"
    }

    columns {
      name = "event_type"
      type = "string"
    }

    columns {
      name = "page_url"
      type = "string"
    }

    columns {
      name = "timestamp"
      type = "timestamp"
    }

    columns {
      name = "device_type"
      type = "string"
    }

    columns {
      name = "browser"
      type = "string"
    }

    columns {
      name = "country"
      type = "string"
    }

    location      = "s3://${aws_s3_bucket.analytics_bucket.bucket}/user-events/"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
    }
  }
}
