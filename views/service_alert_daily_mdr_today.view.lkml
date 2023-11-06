view: service_alert_daily_mdr_today {
  sql_table_name: "PUBLIC"."SERVICE_ALERT_DAILY_MDR_TODAY" ;;

  dimension_group: service_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."SERVICE_DATETIME" ;;
  }
  dimension: sub_name {
    type: string
    sql: ${TABLE}."SUB_NAME" ;;
  }
  dimension: subscriber_id {
    type: number
    sql: ${TABLE}."SUBSCRIBER_ID" ;;
  }
  dimension: sum_device_rate {
    type: number
    sql: ${TABLE}."SUM_DEVICE_RATE" ;;
  }
  dimension: sum_device_rate_fp {
    type: number
    sql: ${TABLE}."SUM_DEVICE_RATE_FP" ;;
  }
  dimension: sum_device_rate_tp {
    type: number
    sql: ${TABLE}."SUM_DEVICE_RATE_TP" ;;
  }
  dimension: sum_device_transactions {
    type: number
    sql: ${TABLE}."SUM_DEVICE_TRANSACTIONS" ;;
  }
  dimension: sum_fp_transactions {
    type: number
    sql: ${TABLE}."SUM_FP_TRANSACTIONS" ;;
  }
  dimension: sum_tp_transactions {
    type: number
    sql: ${TABLE}."SUM_TP_TRANSACTIONS" ;;
  }
  dimension: sum_transactions {
    type: number
    sql: ${TABLE}."SUM_TRANSACTIONS" ;;
  }
  measure: count {
    type: count
    drill_fields: [sub_name]
  }
}
