view: service_alert_daily_mdr_by_period_int {
  sql_table_name: "PUBLIC"."SERVICE_ALERT_DAILY_MDR_BY_PERIOD_INT" ;;

  dimension_group: act_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."ACT_DATE_DATE" ;;
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
    drill_fields: [sub_name, integration_point_name, message_name]
  }
  measure: week_cnt {
    type: count
  }
  measure: avg_txn {
    type: number
    sql: ROUND(AVG(${sum_transactions}),0) ;;
  }

  measure: avg_txn_device {
    type: number
    sql: ROUND(AVG(${sum_device_transactions} / ${sum_transactions}),5) ;;
  }

  measure: stdd_txn {
    type: number
    sql: STDDEV(${sum_transactions}) ;;
  }

  measure: stdd_txn_device {
    type: number
    sql: ROUND(STDDEV(${sum_device_transactions} / ${sum_transactions}),5) ;;
  }
}
