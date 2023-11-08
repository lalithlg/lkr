view: new_dt_service_alert_device_capture {
  derived_table: {
    explore_source: service_alert_device_capture {
      column: subscriber_id {
        field: service_alert_device_capture.subscriber_id
      }
      column: act_date {
        field: service_alert_device_capture.act_date
      }

      column: sum_tp_transactions_raw  {
        field: service_alert_device_capture.sum_tp_transactions_raw
      }
      column: week_cnt  {
        field: service_alert_device_capture.week_cnt
      }

    }
  }
  dimension: subscriber_id {
    label: "Subscriber Code"
    type: number
    value_format_name: id
  }
  dimension_group: act_date {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.act_date_date ;;
  }

  measure: week_cnt {
    type: count
  }


}:
