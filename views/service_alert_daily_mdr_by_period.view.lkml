view: service_alert_daily_mdr_by_period {
  drill_fields: [sub_name,integration_point_name]
  sql_table_name: "PUBLIC"."SERVICE_ALERT_DAILY_MDR_BY_PERIOD" ;;

  dimension_group: act_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."ACT_DATE_DATE" ;;
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
  dimension: avg_txn_device_tp {
    type: number
    sql: ${TABLE}."AVG_TXN_DEVICE_TP" ;;
  }
  dimension: integration_point_name {
    type: string
    sql: ${TABLE}."INTEGRATION_POINT_NAME" ;;
  }
  dimension: is_before_act_time {
    type: yesno
    sql: ${TABLE}."IS_BEFORE_ACT_TIME" ;;
  }
  dimension: is_on_act_time {
    type: yesno
    sql: ${TABLE}."IS_ON_ACT_TIME" ;;
  }
  dimension: message_name {
    type: string
    sql: ${TABLE}."MESSAGE_NAME" ;;
  }
  dimension_group: service_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."SERVICE_DATETIME_DATE" ;;
  }
  dimension: stdd_txn {
    type: number
    sql: ${TABLE}."STDD_TXN" ;;
  }
  dimension: stdd_txn_device {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE" ;;
  }
  dimension: stdd_txn_device_fp {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE_FP" ;;
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
  dimension: week_cnt {
    type: number
    sql: ${TABLE}."WEEK_CNT" ;;

  }
  dimension: concatenated_name {
    type: string
    sql: CONCAT(${TABLE}."SUB_NAME", ' - ', ${TABLE}."INTEGRATION_POINT_NAME") ;;
  }

  measure: count {
    type: count
    drill_fields: [user_details*]
  }
  set: user_details {
    fields: [sub_name, integration_point_name, message_name]
  }
  measure: week_cnt_1 {
    type: count
  }
  measure: avg_txn_1 {
    type: number
    sql: ROUND(AVG(${sum_transactions}),0) ;;
  }

  measure: avg_txn_device_1 {
    type: number
    sql: ROUND(AVG(${sum_device_transactions} / ${sum_transactions}),5) ;;
  }

  measure: avg_txn_device_fp_1 {
    type: number
    sql: ROUND(AVG(${sum_fp_transactions} / ${sum_transactions}),5) ;;
  }

  measure: avg_txn_device_tp_1 {
    type: number
    sql: ROUND(AVG(${sum_tp_transactions} / ${sum_transactions}),5) ;;
  }

  measure: stdd_txn_1 {
    type: number
    sql: STDDEV(${sum_transactions}) ;;
  }

  measure: stdd_txn_fp_1 {
    type: number
    sql: STDDEV(${sum_fp_transactions}) ;;
  }

  measure: stdd_txn_tp_1 {
    type: number
    sql: STDDEV(${sum_tp_transactions}) ;;
  }

  measure: stdd_txn_device_1 {
    type: number
    sql: ROUND(STDDEV(${sum_device_transactions} / ${sum_transactions}),5) ;;
  }

  measure: stdd_txn_device_fp_1 {
    type: number
    sql: ROUND(STDDEV(${sum_fp_transactions} / ${sum_transactions}),5) ;;
  }

  measure: stdd_txn_device_tp_1 {
    type: number
    sql: ROUND(STDDEV(${sum_tp_transactions} / ${sum_transactions}),5) ;;
  }
}
