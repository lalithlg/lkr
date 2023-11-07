
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
  dimension: stdd_txn_device_tp {
    hidden: yes
    value_format_name: decimal_2
    type: number
  }

  set: detail {
    fields: [
        user_id,
  subscriber_count,
  total_avg_txn
    ]
  }
}
