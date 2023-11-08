view: service_alert_new_first_party {
  sql_table_name: "PUBLIC"."SERVICE_ALERT_NEW_FIRST_PARTY" ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  dimension_group: act_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."ACT_DATE" ;;
  }
  dimension_group: first_seen {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."FIRST_SEEN_DATE" ;;
  }
  dimension: is_new {
    type: yesno
    sql: ${TABLE}."IS_NEW" ;;
  }
  dimension: is_on_act_time {
    type: yesno
    sql: ${TABLE}."IS_ON_ACT_TIME" ;;
  }
  dimension: subscriber_id {
    type: number
    sql: ${TABLE}."SUBSCRIBER_ID" ;;
  }
  dimension: FIRST_SEEN_DATE {
    type: yesno
    sql: CASE WHEN CONCAT(${TABLE}."fields", '"fields":') LIKE '%FIRST_SEEN_DATE%' THEN 'Yes' ELSE 'No' END ;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
  measure: current_transactions {
    type: number
    label: "Current Transaction Count"
    sql: ${service_alert_device_capture.sum_transactions} ;;

  }

  measure: current_device_transactions {
    type: number
    label: "Current Device Transaction Count"
    sql: ${service_alert_device_capture.sum_device_transactions} ;;

  }

  measure: current_fp_transactions {
    type: number
    label: "Current 1st Party Transaction Count"
    sql: ${service_alert_device_capture.sum_fp_transactions} ;;

  }

  measure: current_tp_transactions {
    type: number
    label: "Current 3rd Party Transaction Count"
    sql: ${service_alert_device_capture.sum_tp_transactions} ;;

  }
  }
