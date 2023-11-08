
view: sql_dt_using_joins {
  derived_table: {
    sql: select 
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD.SUBSCRIBER_ID,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD_INT.sub_name                 ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD_INT.integration_point_name   ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD_INT.service_datetime_date      ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD_INT.sum_transactions         ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD_INT.sum_device_transactions  ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD_INT.sum_fp_transactions      ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD_INT.sum_tp_transactions , 
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD.avg_txn_device           ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD.avg_txn_device_fp        ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD.avg_txn_device_tp        ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD.stdd_txn_device          ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD.stdd_txn_device_fp       ,
      SERVICE_ALERT_DAILY_MDR_BY_PERIOD.stdd_txn_device_tp       
      from SERVICE_ALERT_DAILY_MDR_BY_PERIOD JOIN SERVICE_ALERT_DAILY_MDR_BY_PERIOD_INT
      ON SERVICE_ALERT_DAILY_MDR_BY_PERIOD.SUBSCRIBER_ID=SERVICE_ALERT_DAILY_MDR_BY_PERIOD_INT.SUBSCRIBER_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: subscriber_id {
    type: number
    sql: ${TABLE}."SUBSCRIBER_ID" ;;
  }

  dimension: sub_name {
    type: string
    sql: ${TABLE}."SUB_NAME" ;;
  }

  dimension: integration_point_name {
    type: string
    sql: ${TABLE}."INTEGRATION_POINT_NAME" ;;
  }

  dimension_group: service_datetime_date {
    type: time
    sql: ${TABLE}."SERVICE_DATETIME_DATE" ;;
  }

  dimension: sum_transactions {
    type: number
    sql: ${TABLE}."SUM_TRANSACTIONS" ;;
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

  set: detail {
    fields: [
        subscriber_id,
	sub_name,
	integration_point_name,
	service_datetime_date_time,
	sum_transactions,
	sum_device_transactions,
	sum_fp_transactions,
	sum_tp_transactions,
	avg_txn_device,
	avg_txn_device_fp,
	avg_txn_device_tp,
	stdd_txn_device,
	stdd_txn_device_fp,
	stdd_txn_device_tp
    ]
  }
}
