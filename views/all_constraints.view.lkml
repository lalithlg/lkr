view: all_constraints {
  sql_table_name: "PUBLIC"."ALL_CONSTRAINTS" ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }
  dimension: is_active {
    type: yesno
    sql: ${TABLE}."IS_ACTIVE" ;;
  }
  dimension_group: registration {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."REGISTRATION_DATE" ;;
  }
  dimension: username {
    type: string
    sql: ${TABLE}."USERNAME" ;;
  }
  measure: count {
    type: count
    drill_fields: [id, username]
  }
}
