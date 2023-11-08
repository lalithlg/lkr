view: new_dt_service_alert_daily_mdr_today {
derived_table: {
  explore_source: service_alert_daily_mdr_today {
    column: subscriber_id  {
      field: service_alert_daily_mdr_today.subscriber_id

    }
  column: sum_tp_transactions   {

    field: service_alert_daily_mdr_today.sum_tp_transactions
    }

    column:  sum_device_rate_fp{
      field: service_alert_daily_mdr_today.sum_device_rate_fp
    }
    column: sum_device_rate_tp {
      field: service_alert_daily_mdr_today.sum_device_rate_tp
    }


  }
  }

  dimension: subscriber_id {
    type: number
  }




  dimension: sum_device_rate_tp {
    label: "Current 3rd Party Device Capture Rate"
    type: number
    value_format_name: percent_2
    sql: round(${TABLE}.sum_device_rate_tp, 5);;

  }
  dimension: sum_device_rate_fp {
    label: "Current 1st Party Device Capture Rate"
    type: number
    value_format_name: percent_2
    sql: round(${TABLE}.sum_device_rate_fp, 5);;
  }
  dimension: sum_tp_transactions {
    type: number
  }

  }
