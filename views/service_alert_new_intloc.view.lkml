view: service_alert_new_intloc {
  sql_table_name: "PUBLIC"."SERVICE_ALERT_NEW_INTLOC" ;;
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
  dimension: intloc {
    type: string
    sql: ${TABLE}."INTLOC" ;;
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
  dimension: name {
    type: string
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
  measure: total_intloc_count {
    type: count_distinct
    label: "Total Intloc Count"
    sql: ${TABLE}."INTLOC" ;;
  }

  measure: new_intloc_count {
    type: count_distinct
    label: "New Intloc Count"
    sql:  ${TABLE}."IS_NEW" ;;
  }

  measure: distinct_subscribr_count {
    type: count_distinct
    label: "Distinct Subscriber Count"
    sql: ${TABLE}."SUBSCRIBER_ID" ;;
  }
}
