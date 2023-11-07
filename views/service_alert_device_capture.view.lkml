view: service_alert_device_capture {
  sql_table_name: "PUBLIC"."SERVICE_ALERT_DEVICE_CAPTURE" ;;

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
  dimension: avg_txn_device_fp {
    type: number
    sql: ${TABLE}."AVG_TXN_DEVICE_FP" ;;
  }
  dimension: avg_txn_device_lbl {
    type: number
    sql: ${TABLE}."AVG_TXN_DEVICE_LBL" ;;
  }
  dimension: avg_txn_device_lbl_fp {
    type: number
    sql: ${TABLE}."AVG_TXN_DEVICE_LBL_FP" ;;
  }
  dimension: avg_txn_device_lbl_tp {
    type: number
    sql: ${TABLE}."AVG_TXN_DEVICE_LBL_TP" ;;
  }
  dimension: avg_txn_device_tp {
    type: number
    sql: ${TABLE}."AVG_TXN_DEVICE_TP" ;;
  }
  dimension: is_alert_raised {
    type: yesno
    sql: ${TABLE}."IS_ALERT_RAISED" ;;
  }
  dimension: is_alert_raised_fp {
    type: yesno
    sql: ${TABLE}."IS_ALERT_RAISED_FP" ;;
  }
  dimension: is_alert_raised_tp {
    type: yesno
    sql: ${TABLE}."IS_ALERT_RAISED_TP" ;;
  }
  dimension: service_time {
    type: string
    sql: ${TABLE}."SERVICE_TIME" ;;
  }
  dimension: sigma {
    type: number
    sql: ${TABLE}."SIGMA" ;;
  }
  dimension: sigma_fp {
    type: number
    sql: ${TABLE}."SIGMA_FP" ;;
  }
  dimension: sigma_lbl {
    type: number
    sql: ${TABLE}."SIGMA_LBL" ;;
  }
  dimension: sigma_lbl_fp {
    type: number
    sql: ${TABLE}."SIGMA_LBL_FP" ;;
  }
  dimension: sigma_lbl_tp {
    type: number
    sql: ${TABLE}."SIGMA_LBL_TP" ;;
  }
  dimension: sigma_tp {
    type: number
    sql: ${TABLE}."SIGMA_TP" ;;
  }
  dimension: stdd_txn_device {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE" ;;
  }
  dimension: stdd_txn_device_fp {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE_FP" ;;
  }
  dimension: stdd_txn_device_lbl {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE_LBL" ;;
  }
  dimension: stdd_txn_device_lbl_fp {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE_LBL_FP" ;;
  }
  dimension: stdd_txn_device_lbl_tp {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE_LBL_TP" ;;
  }
  dimension: stdd_txn_device_tp {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE_TP" ;;
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
    html: {% if value >= 0 %}
    <b><p style="color: green;   text-align:right">{{ rendered_value }}</p></b>
    {% else %}
    <b><p style="color: red;   text-align:right">{{ rendered_value }}</p></b>
    {% endif %} ;;
  }
  measure: count {
    type: count
    drill_fields: [sub_name]
  }
}
