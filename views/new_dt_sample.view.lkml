view: new_dt_sample {
  derived_table: {
    explore_source: service_alert_daily_mdr_by_period {
      column: subscriber_id {
        field: service_alert_daily_mdr_by_period.subscriber_id
        }
      column: sub_name {
        field:service_alert_daily_mdr_by_period.sub_name
      }
      column: act_date_date {
        field: service_alert_daily_mdr_by_period.act_date_date
      }
      column: avg_txn {
        field:  service_alert_daily_mdr_by_period.avg_txn
      }
      column: stdd_txn {
        field: service_alert_daily_mdr_by_period.stdd_txn
      }
      column: avg_txn_device {
        field: service_alert_daily_mdr_by_period.avg_txn_device
      }
      column: avg_txn_device_fp {
        field: service_alert_daily_mdr_by_period.avg_txn_device_fp
      }
      column: avg_txn_device_tp {
        field:service_alert_daily_mdr_by_period.avg_txn_device_tp
        }
      column: stdd_txn_device {
        field: service_alert_daily_mdr_by_period.stdd_txn_device
      }
      column: stdd_txn_device_fp {
        field: service_alert_daily_mdr_by_period.stdd_txn_device_fp
      }
      column: stdd_txn_device_tp {
        field: service_alert_daily_mdr_by_period.stdd_txn_device_tp
      }

      column: sum_transactions {
        field:service_alert_daily_mdr_by_period.sum_transactions
      }
      derived_column: some_thing {
        sql: row_number() over (order by sum_transactions desc) ;;
      }


    }
  }


dimension: subscriber_id {
  type: number
  sql: ${TABLE}."SUBSCRIBER_ID" ;;
}
  dimension: sub_name {
    type: string
    sql: ${TABLE}."SUB_NAME" ;;
  }
  dimension_group: act_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."ACT_DATE_DATE" ;;
  }
  dimension: avg_txn {
    type: number
    sql: ${TABLE}."AVG_TXN" ;;
  }
  dimension: stdd_txn {
    type: number
    sql: ${TABLE}."STDD_TXN" ;;
  }
  dimension: stdd_txn_device {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE" ;;
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

  dimension: stdd_txn_device_fp {
    type: number
    sql: ${TABLE}."STDD_TXN_DEVICE_FP" ;;
  }

  dimension: sum_transactions {
    type: number
    sql: ${TABLE}."SUM_TRANSACTIONS" ;;
  }
  dimension: some_thing {
    type:number
    label: "derived column something"
  }
}
