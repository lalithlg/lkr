view: service_alert_daily_mdr_txn {
  sql_table_name: "PUBLIC"."SERVICE_ALERT_DAILY_MDR_TXN" ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  dimension_group: act_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."ACT_DATE_DATE" ;;
  }
  dimension: act_date_rw {
    type: number
    sql: ${TABLE}."ACT_DATE_RAW" ;;
  }
  dimension: dynamic_report_type {
    type: string
    sql: ${TABLE}."DYNAMIC_REPORT_TYPE" ;;
  }
  dimension: integration_point_name {
    type: string
    sql: ${TABLE}."INTEGRATION_POINT_NAME" ;;
  }
  dimension: intloc {
    type: string
    sql: ${TABLE}."INTLOC" ;;
  }
  dimension: report_type {
    type: string
    sql: ${TABLE}."REPORT_TYPE" ;;
  }
  dimension_group: service_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."SERVICE_DATETIME_DATE" ;;
  }
  dimension: service_datetime_rw {
    type: number
    sql: ${TABLE}."SERVICE_DATETIME_RAW" ;;
  }
  dimension: subscriber_id {
    type: number
    sql: ${TABLE}."SUBSCRIBER_ID" ;;
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
    drill_fields: [id, integration_point_name]
  }
}
