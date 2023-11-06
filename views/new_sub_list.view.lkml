view: new_sub_list {
  sql_table_name: "PUBLIC"."NEW_SUB_LIST" ;;

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
  dimension_group: service_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."SERVICE_DATETIME" ;;
  }
  dimension: subscriber_id {
    type: number
    sql: ${TABLE}."SUBSCRIBER_ID" ;;
  }
  measure: count {
    type: count
  }
}
