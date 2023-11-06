connection: "sfty-snowflake"

include: "/views/*.view.lkml"

view: service_alert_device_cap {
  derived_table: {
    explore_source: service_alert_daily_mdr_by_period {
      column: subscriber_id {}
      column: sub_name {}

      column: act_date_date {}
      column: avg_txn {}
      column: stdd_txn {}
      column: avg_txn_device {}
      column: avg_txn_device_fp {}
      column: avg_txn_device_tp {}
      column: stdd_txn_device {}
      column: stdd_txn_device_fp {}
      column: stdd_txn_device_tp {}
      column: week_cnt {}

      filters: {
        field: service_alert_daily_mdr_by_period.is_before_act_time
        value: "Yes"
      }


      bind_filters: {
        to_field: service_alert_daily_mdr_by_period.subscriber_id
        from_field: service_alert_device_capture.subscriber_id
      }
      bind_filters: {
        to_field: service_alert_daily_mdr_by_period.sub_name
        from_field: service_alert_device_capture.sub_name
      }
      bind_filters: {

        to_field: service_alert_daily_mdr_by_period.report_type
        from_field: service_alert_device_capture.report_type

      }
    }
  }

  parameter: report_type {
    type: unquoted
    allowed_value: {
      label: "Device Capture"
      value: "dc"
    }

    allowed_value: {
      label: "Others"
      value: "other"
    }

  }


  dimension: subscriber_id {
    label: "Subscriber Code"
    type: number
    value_format_name: id
  }
  }
