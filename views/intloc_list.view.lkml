view: intloc_list {
  sql_table_name: "PUBLIC"."INTLOC_LIST" ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  dimension_group: act {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."ACT_DATE" ;;
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
  dimension: intloc {
    type: string
    sql: ${TABLE}."INTLOC" ;;
  }
  dimension_group: min_service2 {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."MIN_SERVICE_DATE" ;;
  }
  dimension: subscriber_id {
    type: number
    sql: ${TABLE}."SUBSCRIBER_ID" ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
