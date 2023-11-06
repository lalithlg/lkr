
view: device_capture {
  derived_table: {
    sql: SELECT
        subscriber_id AS user_id,
        COUNT(SUBSCRIBER_ID) AS subscriber_count,
        SUM(AVG_TXN) AS total_AVG_TXN
      FROM SERVICE_ALERT_DEVICE_CAPTURE_INT
      GROUP BY subscriber_id ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: subscriber_count {
    type: number
    sql: ${TABLE}."SUBSCRIBER_COUNT" ;;
  }

  dimension: total_avg_txn {
    type: number
    sql: ${TABLE}."TOTAL_AVG_TXN" ;;
  }

  set: detail {
    fields: [
        user_id,
  subscriber_count,
  total_avg_txn
    ]
  }
}
