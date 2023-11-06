view: service_alert_device_capture_int {
  sql_table_name: "PUBLIC"."SERVICE_ALERT_DEVICE_CAPTURE_INT" ;;

  dimension_group: act {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."ACT_DATE" ;;
  }
  dimension: avg_txn {
    type: number
    sql: ${TABLE}."AVG_TXN" ;;
  }
  dimension: avg_txn_device {
    type: number
    sql: ${TABLE}."AVG_TXN_DEVICE" ;;
  }
  dimension: avg_txn_device_lbl {
    type: number
    sql: ${TABLE}."AVG_TXN_DEVICE_LBL" ;;
  }
  dimension: integration_point_name {
    type: string
    sql: ${TABLE}."INTEGRATION_POINT_NAME" ;;
  }
  dimension: is_alert_raised {
    type: yesno
    sql: ${TABLE}."IS_ALERT_RAISED" ;;
  }
  dimension: service_time {
    type: string
    sql: ${TABLE}."SERVICE_TIME" ;;
  }
  dimension: sigma {
    type: number
    sql: ${TABLE}."SIGMA" ;;
  }
  dimension: sigma_lbl {
    type: number
    sql: ${TABLE}."SIGMA_LBL" ;;
  }
  dimension: stdd_txn_device {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE" ;;
  }
  dimension: stdd_txn_device_lbl {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE_LBL" ;;
  }
  dimension: sub_name {
    type: string
    sql: ${TABLE}."SUB_NAME" ;;
  }
  dimension: subscriber_id {
    type: number
    sql: ${TABLE}."SUBSCRIBER_ID" ;;
  }
  dimension: sum_device_transactions {
    type: number
    sql: ${TABLE}."SUM_DEVICE_TRANSACTIONS" ;;
  }
  dimension: sum_device_transactions_raw {
    type: number
    sql: ${TABLE}."SUM_DEVICE_TRANSACTIONS_RAW" ;;
  }
  dimension: sum_fp_transactions {
    type: number
    sql: ${TABLE}."SUM_FP_TRANSACTIONS" ;;
  }
  dimension: sum_fp_transactions_raw {
    type: number
    sql: ${TABLE}."SUM_FP_TRANSACTIONS_RAW" ;;
  }
  dimension: sum_tp_transactions {
    type: number
    sql: ${TABLE}."SUM_TP_TRANSACTIONS" ;;
  }
  dimension: sum_tp_transactions_raw {
    type: number
    sql: ${TABLE}."SUM_TP_TRANSACTIONS_RAW" ;;
  }
  dimension: sum_transactions {
    type: number
    sql: ${TABLE}."SUM_TRANSACTIONS" ;;
  }
  dimension: sum_transactions_raw {
    type: number
    sql: ${TABLE}."SUM_TRANSACTIONS_RAW" ;;
  }
  dimension: txn_avg_period {
    type: string
    sql: ${TABLE}."TXN_AVG_PERIOD" ;;
  }
  dimension: week_cnt {
    type: number
    sql: ${TABLE}."WEEK_CNT" ;;
  }
  measure: count {
    type: count
    drill_fields: [integration_point_name, sub_name]
  }
}
