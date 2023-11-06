include: "../basic/*.lkml"

#########################################################################
#   Device Capture (DC) All Volume Alert, DC 1st Party/3rd Party Volume #
#########################################################################
explore: service_alert_device_capture {
  hidden: no
  extends: [sub_info]


  join: today {
    from: service_alert_daily_mdr_today
    type: left_outer
    relationship: one_to_one
    sql_on: ${service_alert_device_capture.subscriber_id} = ${today.subscriber_id}

                AND ${service_alert_device_capture.act_date_raw} = ${today.service_datetime_raw};;
  }

  join: sub_info {
    sql_where: ${sub_info.is_status_active} ;;
    relationship: one_to_one
    type: inner
    sql_on: ${service_alert_device_capture.subscriber_id} = ${sub_info.subscriber_id};;
  }
}


view: service_alert_device_capture {
  derived_table: {
    explore_source: service_alert_daily_mdr_by_period {
      column: subscriber_id {}
      column: sub_name {}

      column: act_date_date {}
      column: avg_txn {}
      column: stdd_txn {}
      column: avg_txn_device {}
      column: avg_txn_device_fp {}
      column: avg_txn_device_tp {}
      column: stdd_txn_device {}
      column: stdd_txn_device_fp {}
      column: stdd_txn_device_tp {}
      column: week_cnt {}

      filters: {
        field: service_alert_daily_mdr_by_period.is_before_act_time
        value: "Yes"
      }


      bind_filters: {
        to_field: service_alert_daily_mdr_by_period.subscriber_id
        from_field: service_alert_device_capture.subscriber_id
      }
      bind_filters: {
        to_field: service_alert_daily_mdr_by_period.sub_name
        from_field: service_alert_device_capture.sub_name
      }
      bind_filters: {

        to_field: service_alert_daily_mdr_by_period.report_type
        from_field: service_alert_device_capture.report_type

      }
    }
  }

  parameter: report_type {
    type: unquoted
    allowed_value: {
      label: "Device Capture"
      value: "dc"
    }

    allowed_value: {
      label: "Others"
      value: "other"
    }

  }


  dimension: subscriber_id {
    label: "Subscriber Code"
    type: number
    value_format_name: id
  }

  dimension: sub_name {
    label: "Subscriber Name"
    type: string
    sql: ${TABLE}.sub_name ;;
  }



  dimension_group: act_date {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.act_date_date ;;
  }

  dimension: service_time {
    type: string
    sql: to_char(${act_date_raw}, 'YYYY-MM-DD') ;;
  }

  dimension: avg_txn {
    label: "Historical Txn Avg"
    type: number
    value_format_name: decimal_0
  }

  dimension: avg_txn_device {
    hidden: yes
    type: number

  }

  dimension: avg_txn_device_lbl {
    label: "Historical Avg"
    type: number
    value_format_name: percent_2
    sql: round((${avg_txn_device} ), 5)::float ;;
  }
  dimension: stdd_txn_device {
    hidden: yes
    value_format_name: decimal_2
    type: number
  }
  dimension: stdd_txn_device_lbl {
    label: "Standard Deviation"
    type: number
    sql: ROUND(${stdd_txn_device},5)::float ;;
    value_format_name: percent_2
  }

  dimension: sigma_lbl {
    label: "Sigma"
    type: number
    value_format_name: decimal_0
    sql: IFNULL((${today.sum_device_rate} - ${avg_txn_device}) / NULLIF(${stdd_txn_device},0),0) ;;
    html: {% if value >= 0 %}
          <b><p style="color: green;   text-align:right">{{ rendered_value }}</p></b>
          {% else %}
           <b><p style="color: red;   text-align:right">{{ rendered_value }}</p></b>
          {% endif %} ;;
  }



  dimension: sigma {
    hidden: yes
    type: number
    sql: IFNULL((${today.sum_device_rate} - ${avg_txn_device}) / NULLIF(${stdd_txn_device},0),0) ;;

  }



  dimension: is_alert_raised {
    type: yesno
    sql:
    (
      ABS(${sigma}) >= 5
    )
    AND ${avg_txn} > 100
    AND ${week_cnt} >= 3
    ;;
  }


  dimension: week_cnt {
    hidden: yes
    type: number
  }

  dimension: txn_avg_period {
    label: "TXN Avg. Period"
    sql:${week_cnt}::string || ' weeks';;
  }

# FP details

  dimension: avg_txn_device_fp {
    hidden: yes
    type: number

  }

  dimension: avg_txn_device_lbl_fp {
    label: "1st Party Historical Avg"
    type: number
    value_format_name: percent_2
    sql: round((${avg_txn_device_fp} ), 5)::float ;;
  }
  dimension: stdd_txn_device_fp {
    hidden: yes
    value_format_name: decimal_2
    type: number
  }
  dimension: stdd_txn_device_lbl_fp {
    label: "1st Party Standard Deviation"
    type: number
    sql: ROUND(${stdd_txn_device_fp},5)::float ;;
    value_format_name: percent_2
  }

  dimension: sigma_lbl_fp {
    label: "1st Party Sigma"
    type: number
    value_format_name: decimal_0
    sql: IFNULL((${today.sum_device_rate_fp} - ${avg_txn_device_fp}) / NULLIF(${stdd_txn_device_fp},0),0) ;;
    html: {% if value >= 0 %}
          <b><p style="color: green;   text-align:right">{{ rendered_value }}</p></b>
          {% else %}
           <b><p style="color: red;   text-align:right">{{ rendered_value }}</p></b>
          {% endif %} ;;
  }



  dimension: sigma_fp {
    hidden: yes
    type: number
    sql: IFNULL((${today.sum_device_rate_fp} - ${avg_txn_device_fp}) / NULLIF(${stdd_txn_device_fp},0),0) ;;

  }



  dimension: is_alert_raised_fp {
    type: yesno
    sql:
    (
      ABS(${sigma_fp}) >= 5
    )
    AND ${avg_txn} > 100
    AND ${week_cnt} >= 3
    ;;
  }

# TP details

  dimension: avg_txn_device_tp {
    hidden: yes
    type: number

  }

  dimension: avg_txn_device_lbl_tp {
    label: "3rd Party Historical Avg"
    type: number
    value_format_name: percent_2
    sql: round((${avg_txn_device_tp} ), 5)::float ;;
  }
  dimension: stdd_txn_device_tp {
    hidden: yes
    value_format_name: decimal_2
    type: number
  }
  dimension: stdd_txn_device_lbl_tp {
    label: "3rd Party Standard Deviation"
    type: number
    sql: ROUND(${stdd_txn_device_tp},5)::float ;;
    value_format_name: percent_2
  }

  dimension: sigma_lbl_tp {
    label: "3rd Party Sigma"
    type: number
    value_format_name: decimal_0
    sql: IFNULL((${today.sum_device_rate_tp} - ${avg_txn_device_tp}) / NULLIF(${stdd_txn_device_tp},0),0) ;;
    html: {% if value >= 0 %}
          <b><p style="color: green;   text-align:right">{{ rendered_value }}</p></b>
          {% else %}
           <b><p style="color: red;   text-align:right">{{ rendered_value }}</p></b>
          {% endif %} ;;
  }



  dimension: sigma_tp {
    hidden: yes
    type: number
    sql: IFNULL((${today.sum_device_rate_tp} - ${avg_txn_device_tp}) / NULLIF(${stdd_txn_device_tp},0),0) ;;

  }



  dimension: is_alert_raised_tp {
    type: yesno
    sql:
    (
      ABS(${sigma_tp}) >= 5
    )
    AND ${avg_txn} > 100
    AND ${week_cnt} >= 3
    ;;
  }

# Today fields
  dimension: sum_transactions_raw {
    type: number
    sql: ${today.sum_transactions} ;;
  }

  dimension: sum_transactions {
    label: "Current Txn Count"
    type: number
    sql: COALESCE(${sum_transactions_raw},0) ;;
  }

  dimension: sum_device_transactions_raw {
    type: number
    sql: ${today.sum_device_transactions} ;;
  }

  dimension: sum_device_transactions {
    label: "Current DC Txn Count"
    type: number
    sql: COALESCE(${sum_device_transactions_raw},0) ;;
  }

  dimension: sum_fp_transactions_raw {
    type: number
    sql: ${today.sum_fp_transactions} ;;
  }

  dimension: sum_fp_transactions {
    label: "Current 1st Party DC Txn Count"
    type: number
    sql: COALESCE(${sum_fp_transactions_raw},0) ;;
  }

  dimension: sum_tp_transactions_raw {
    type: number
    sql: ${today.sum_tp_transactions} ;;
  }

  dimension: sum_tp_transactions {
    label: "Current 3rd Party DC Txn Count"
    type: number
    sql: COALESCE(${sum_tp_transactions_raw},0) ;;
  }


}

view: service_alert_daily_mdr_today {
  derived_table: {
    explore_source: service_alert_daily_mdr_by_period {

      column: service_datetime_date {}
      column: subscriber_id {}
      column: sub_name {}
      column: sum_transactions {}
      column: sum_device_transactions {}
      column: sum_fp_transactions {}
      column: sum_tp_transactions {}
      derived_column: sum_device_rate {sql: sum_device_transactions / sum_transactions;;}
      derived_column: sum_device_rate_fp {sql: sum_fp_transactions / sum_transactions;;}
      derived_column: sum_device_rate_tp {sql: sum_tp_transactions / sum_transactions;;}



      bind_filters: {
        to_field: service_alert_daily_mdr_by_period.subscriber_id
        from_field: service_alert_device_capture.subscriber_id
      }

      bind_filters: {
        to_field: service_alert_daily_mdr_by_period.sub_name
        from_field: service_alert_device_capture.sub_name
      }

      filters: {
        field: service_alert_daily_mdr_by_period.is_on_act_time
        value: "Yes"
      }
  bind_filters: {
    to_field: service_alert_daily_mdr_by_period.report_type
    from_field: service_alert_device_capture.report_type
  }

}
}

parameter: report_type {
  type: unquoted
  allowed_value: {
    label: "Device Capture"
    value: "dc"
  }

  allowed_value: {
    label: "Others"
    value: "other"
  }

}


  dimension_group: service_datetime {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.service_datetime_date ;;
  }

  dimension: subscriber_id {
    type: number
  }
  dimension: sub_name {
    type: string
  }
  dimension: sum_transactions {
    type: number
  }
  dimension: sum_device_transactions {
    type: number
  }

  dimension: sum_fp_transactions {
    type: number
  }
  dimension: sum_tp_transactions {
    type: number
  }

  dimension: sum_device_rate {
    label: "Current Device Capture Rate"
    type: number
    value_format_name: percent_2
    sql: round(${TABLE}.sum_device_rate, 5);;
  }
  dimension: sum_device_rate_fp {
      label: "Current 1st Party Device Capture Rate"
      type: number
      value_format_name: percent_2
      sql: round(${TABLE}.sum_device_rate_fp, 5);;
  }
  dimension: sum_device_rate_tp {
      label: "Current 3rd Party Device Capture Rate"
      type: number
      value_format_name: percent_2
      sql: round(${TABLE}.sum_device_rate_tp, 5);;

  }
}

explore: service_alert_daily_mdr_by_period
{hidden:yes }

view: service_alert_daily_mdr_by_period {
  derived_table: {
    explore_source: service_alert_daily_mdr_txn {
      column: subscriber_id {}
      column: sub_name {field:sub_info1.sub_name}

      column: service_datetime_date {}
      column: sum_transactions {}
      column: sum_device_transactions {}
      column: sum_fp_transactions {}
      column: sum_tp_transactions {}
      column: act_date_date {}


      bind_filters: {
        to_field: service_alert_daily_mdr_txn.subscriber_id
        from_field: service_alert_daily_mdr_by_period.subscriber_id
      }

      bind_filters: {
        to_field: sub_info1.sub_name
        from_field: service_alert_daily_mdr_by_period.sub_name
      }
  bind_filters: {
    to_field: service_alert_daily_mdr_txn.report_type
    from_field: service_alert_daily_mdr_by_period.report_type
  }
}
}

parameter: report_type {
  type: unquoted
  allowed_value: {
    label: "Device Capture"
    value: "dc"
  }

  allowed_value: {
    label: "Others"
    value: "other"
  }

}


  dimension: subscriber_id {
    type: number
  }

  dimension: sub_name {
    type: string
  }

  dimension: message_name {}

  dimension_group: service_datetime {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.service_datetime_date ;;
  }

  dimension: is_before_act_time {
    type: yesno
    sql: ${service_datetime_raw} < ${act_date_raw} ;;
  }

  dimension: is_on_act_time {
    type: yesno
    sql: ${service_datetime_raw} = ${act_date_raw} ;;
  }

  dimension: sum_transactions {
    type: number
  }

  dimension: sum_device_transactions {
    type: number
  }

  dimension: sum_fp_transactions {
    type: number
  }

  dimension: sum_tp_transactions {
    type: number
  }

  dimension_group: act_date {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.act_date_date ;;
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

  measure: avg_txn_device_fp {
    type: number
    sql: ROUND(AVG(${sum_fp_transactions} / ${sum_transactions}),5) ;;
  }

  measure: avg_txn_device_tp {
    type: number
    sql: ROUND(AVG(${sum_tp_transactions} / ${sum_transactions}),5) ;;
  }

  measure: stdd_txn {
    type: number
    sql: STDDEV(${sum_transactions}) ;;
  }

  measure: stdd_txn_fp {
    type: number
    sql: STDDEV(${sum_fp_transactions}) ;;
  }

  measure: stdd_txn_tp {
    type: number
    sql: STDDEV(${sum_tp_transactions}) ;;
  }

  measure: stdd_txn_device {
    type: number
    sql: ROUND(STDDEV(${sum_device_transactions} / ${sum_transactions}),5) ;;
  }

  measure: stdd_txn_device_fp {
    type: number
    sql: ROUND(STDDEV(${sum_fp_transactions} / ${sum_transactions}),5) ;;
  }

  measure: stdd_txn_device_tp {
    type: number
    sql: ROUND(STDDEV(${sum_tp_transactions} / ${sum_transactions}),5) ;;
  }

}

#
# Include only WEB transactions for TP and FP alert
#
explore: service_alert_daily_mdr_txn {
  fields: [service_alert_daily_mdr_txn.cols*, sub_info1.sub_name]
  sql_always_having: ${sum_transactions} > 0 ;;
  hidden: yes
  join: asof {
    from: daily_mdr_max_ts
    type: cross
    relationship: many_to_one
    sql_where:
      ${service_alert_daily_mdr_txn.service_datetime_raw} >= ${asof.act_date_raw} - INTERVAL '43 days'
      AND DAYOFWEEK(${service_alert_daily_mdr_txn.service_datetime_raw}) = ${asof.act_day_of_week}

       AND IFF(${service_alert_daily_mdr_txn.dynamic_report_type} = 'true', TRUE,
      ${service_alert_daily_mdr_txn.intloc} != 'n/a')
    ;;
  }

  join: sub_info1  {
    from: view_subscribers
    relationship: many_to_one
    type: inner
    sql_on: ${service_alert_daily_mdr_txn.subscriber_id} = ${sub_info1.subscriber_id}

                           and  ${sub_info1.is_customer} and ${sub_info1.subscriber_id} not in (7400) ;;
  }
}



view: service_alert_daily_mdr_txn {
  extends: [daily_mdr_rollup]

  dimension: id {primary_key: no hidden:yes}
  set: cols {
    fields: [
      report_type,
      subscriber_id,
      integration_point_name,
      service_datetime_raw,
      service_datetime_date,
      act_date_raw,
      act_date_date,
      intloc,
      sum_transactions,
      sum_device_transactions,
      sum_fp_transactions,
      sum_tp_transactions
    ]
  }

  parameter: report_type {
    type: unquoted
    allowed_value: {
      label: "Device Capture"
      value: "dc"
    }

    allowed_value: {
      label: "Others"
      value: "other"
    }

  }

  dimension: dynamic_report_type {
    label_from_parameter: report_type
    type: string
    sql:
    {% if report_type._parameter_value == 'dc' %}
      'true'
    {% else %}
      'false'
    {% endif %};;
  }

  dimension_group: act_date {
    type: time
    timeframes: [raw, date]
    sql: ${asof.act_date_raw} ;;
  }

}



view: daily_mdr_max_ts {
  derived_table: {
    explore_source: daily_mdr_rollup {
      column: last_seen {field: daily_mdr_rollup.max_service_date}

    }
  }


  dimension_group: act_date {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.last_seen ;;
  }
  dimension: act_day_of_week {
    type: number
    sql: DAYOFWEEK(${act_date_raw}) ;;
  }
}

######################################################
#   Device Capture Volume Alert By Integration Point
######################################################
explore: service_alert_device_capture_int {
  hidden: no
  extends: [sub_info]
  sql_always_where: ${is_alert_raised} ;;

  join: today {
    from: service_alert_daily_mdr_today_int
    type: left_outer
    relationship: one_to_one
    sql_on: ${service_alert_device_capture_int.subscriber_id} = ${today.subscriber_id}
                      AND  ${service_alert_device_capture_int.integration_point_name} = ${today.integration_point_name}
                      AND ${service_alert_device_capture_int.act_date_raw} = ${today.service_datetime_raw};;
  }

  join: sub_info {
    sql_where: ${sub_info.is_status_active} ;;
    relationship: one_to_one
    type: inner
    sql_on: ${service_alert_device_capture_int.subscriber_id} = ${sub_info.subscriber_id};;
  }


}

view: service_alert_device_capture_int {
  derived_table: {
    explore_source: service_alert_daily_mdr_by_period_int {
      column: subscriber_id {}
      column: sub_name {}
      column: integration_point_name {}
      column: act_date_date {}
      column: avg_txn {}
      column: stdd_txn {}
      column: avg_txn_device {}
      column: stdd_txn_device {}
      column: week_cnt {}

      filters: {
        field: service_alert_daily_mdr_by_period_int.is_before_act_time
        value: "Yes"
      }
      bind_filters: {
        to_field: service_alert_daily_mdr_by_period_int.integration_point_name
        from_field: service_alert_device_capture_int.integration_point_name
      }

      bind_filters: {
        to_field: service_alert_daily_mdr_by_period_int.subscriber_id
        from_field: service_alert_device_capture_int.subscriber_id
      }
      bind_filters: {
        to_field: service_alert_daily_mdr_by_period_int.sub_name
        from_field: service_alert_device_capture_int.sub_name
      }
    }
  }

  parameter: p_deviation {
    type: string
    default_value: "-5"
  }

  parameter: p_min_txn  {
    type: number
    default_value: "100"
  }

  dimension: subscriber_id {
    label: "Subscriber Code"
    type: number
    value_format_name: id
  }

  dimension: sub_name {
    label: "Subscriber Name"
    type: string
    sql: ${TABLE}.sub_name ;;
  }

  dimension: integration_point_name {
    label: "Integration point"
    type: string
    sql: ${TABLE}.integration_point_name ;;
  }


  dimension_group: act_date {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.act_date_date ;;
  }

  dimension: service_time {
    type: string
    sql: to_char(${act_date_raw}, 'YYYY-MM-DD') ;;
  }

  dimension: avg_txn {
    label: "Historical Txn Avg"
    type: number
    value_format_name: decimal_0
  }

  dimension: avg_txn_device {
    hidden: yes
    type: number

  }

  dimension: avg_txn_device_lbl {
    label: "Historical Avg"
    type: number
    value_format_name: percent_2
    sql: round((${avg_txn_device} ), 5)::float ;;
  }
  dimension: stdd_txn_device {
    hidden: yes
    value_format_name: decimal_2
    type: number
  }
  dimension: stdd_txn_device_lbl {
    label: "Standard Deviation"
    type: number
    sql: ROUND(${stdd_txn_device},5)::float ;;
    value_format_name: percent_2
  }

  dimension: sigma_lbl {
    label: "Sigma"
    type: number
    value_format_name: decimal_0
    sql: IFNULL((${today.sum_device_rate} - ${avg_txn_device}) / NULLIF(${stdd_txn_device},0),0) ;;
    html: {% if value >= 0 %}
          <b><p style="color: green;   text-align:right">{{ rendered_value }}</p></b>
          {% else %}
           <b><p style="color: red;   text-align:right">{{ rendered_value }}</p></b>
          {% endif %} ;;
  }



  dimension: sigma {
    hidden: yes
    type: number
    sql: IFNULL((${today.sum_device_rate} - ${avg_txn_device}) / NULLIF(${stdd_txn_device},0),0) ;;

  }



  dimension: is_alert_raised {
    type: yesno
    sql:
    (
      ${sigma} < to_number ({% parameter service_alert_device_capture_int.p_deviation %})
    )
    AND ${avg_txn} > {% parameter service_alert_device_capture_int.p_min_txn %}
    AND ${week_cnt} >= 3
    AND ${avg_txn_device} > 0.10
    ;;
  }


  dimension: week_cnt {
    hidden: yes
    type: number
  }

  dimension: txn_avg_period {
    label: "TXN Avg. Period"
    sql:${week_cnt}::string || ' weeks';;
  }

# Today fields
  dimension: sum_transactions_raw {
    type: number
    sql: ${today.sum_transactions} ;;
  }

  dimension: sum_transactions {
    label: "Current Txn Count"
    type: number
    sql: COALESCE(${sum_transactions_raw},0) ;;
  }

  dimension: sum_device_transactions_raw {
    type: number
    sql: ${today.sum_device_transactions} ;;
  }

  dimension: sum_device_transactions {
    label: "Current DC Txn Count"
    type: number
    sql: COALESCE(${sum_device_transactions_raw},0) ;;
  }

  dimension: sum_fp_transactions_raw {
    type: number
    sql: ${today.sum_fp_transactions} ;;
  }

  dimension: sum_fp_transactions {
    label: "Current 1st Party DC Txn Count"
    type: number
    sql: COALESCE(${sum_fp_transactions_raw},0) ;;
  }

  dimension: sum_tp_transactions_raw {
    type: number
    sql: ${today.sum_tp_transactions} ;;
  }

  dimension: sum_tp_transactions {
    label: "Current 3rd Party DC Txn Count"
    type: number
    sql: COALESCE(${sum_tp_transactions_raw},0) ;;
  }


}

view: service_alert_daily_mdr_today_int {
  derived_table: {
    explore_source: service_alert_daily_mdr_by_period_int {

      column: service_datetime_date {}
      column: subscriber_id {}
      column: sub_name {}
      column: integration_point_name {}
      column: sum_transactions {}
      column: sum_device_transactions {}
      column: sum_fp_transactions {}
      column: sum_tp_transactions {}
      derived_column: sum_device_rate {sql: sum_device_transactions / sum_transactions;;}



      bind_filters: {
        to_field: service_alert_daily_mdr_by_period_int.subscriber_id
        from_field: service_alert_device_capture_int.subscriber_id
      }

      bind_filters: {
        to_field: service_alert_daily_mdr_by_period_int.sub_name
        from_field: service_alert_device_capture_int.sub_name
      }

      bind_filters: {
        to_field: service_alert_daily_mdr_by_period_int.integration_point_name
        from_field: service_alert_device_capture_int.integration_point_name
      }

      filters: {
        field: service_alert_daily_mdr_by_period_int.is_on_act_time
        value: "Yes"
      }

    }
  }


  dimension_group: service_datetime {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.service_datetime_date ;;
  }

  dimension: subscriber_id {
    type: number
  }
  dimension: sub_name {
    type: string
  }
  dimension: integration_point_name {
    type: string
  }
  dimension: sum_transactions {
    type: number
  }
  dimension: sum_device_transactions {
    type: number
  }

  dimension: sum_fp_transactions {
    type: number
  }
  dimension: sum_tp_transactions {
    type: number
  }

  dimension: sum_device_rate {
    label: "Current Device Capture Rate"
    type: number
    value_format_name: percent_2
    sql: round(${TABLE}.sum_device_rate, 5);;

  }
}

explore: service_alert_daily_mdr_by_period_int
{hidden:yes }

view: service_alert_daily_mdr_by_period_int {
  derived_table: {
    explore_source: service_alert_daily_mdr_txn_int {
      column: subscriber_id {}
      column: sub_name {field:sub_info1.sub_name}
      column: integration_point_name {}
      column: service_datetime_date {}
      column: sum_transactions {}
      column: sum_device_transactions {}
      column: sum_fp_transactions {}
      column: sum_tp_transactions {}
      column: act_date_date {}
      bind_filters: {
        to_field: service_alert_daily_mdr_txn_int.integration_point_name
        from_field: service_alert_daily_mdr_by_period_int.integration_point_name
      }

      bind_filters: {
        to_field: service_alert_daily_mdr_txn_int.subscriber_id
        from_field: service_alert_daily_mdr_by_period_int.subscriber_id
      }

      bind_filters: {
        to_field: sub_info1.sub_name
        from_field: service_alert_daily_mdr_by_period_int.sub_name
      }
    }
  }

  dimension: subscriber_id {
    type: number
  }

  dimension: sub_name {
    type: string
  }

  dimension: message_name {}

  dimension: integration_point_name {}

  dimension_group: service_datetime {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.service_datetime_date ;;
  }

  dimension: is_before_act_time {
    type: yesno
    sql: ${service_datetime_raw} < ${act_date_raw} ;;
  }

  dimension: is_on_act_time {
    type: yesno
    sql: ${service_datetime_raw} = ${act_date_raw} ;;
  }

  dimension: sum_transactions {
    type: number
  }

  dimension: sum_device_transactions {
    type: number
  }

  dimension: sum_fp_transactions {
    type: number
  }

  dimension: sum_tp_transactions {
    type: number
  }

  dimension_group: act_date {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.act_date_date ;;
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

explore: service_alert_daily_mdr_txn_int {
  fields: [service_alert_daily_mdr_txn_int.cols*, sub_info1.sub_name]
  sql_always_having: ${sum_transactions} > 0 ;;
  hidden: yes
  join: asof {
    from: daily_mdr_max_ts
    type: cross
    relationship: many_to_one
    sql_where:
      ${service_alert_daily_mdr_txn_int.service_datetime_raw} >= ${asof.act_date_raw} - INTERVAL '43 days'
      AND DAYOFWEEK(${service_alert_daily_mdr_txn_int.service_datetime_raw}) = ${asof.act_day_of_week}
    ;;
  }

  join: sub_info1  {
    from: view_subscribers
    relationship: many_to_one
    type: inner
    sql_on: ${service_alert_daily_mdr_txn_int.subscriber_id} = ${sub_info1.subscriber_id}

                                       and  ${sub_info1.is_customer} and ${sub_info1.subscriber_id} not in (7400) ;;
  }
}



view: service_alert_daily_mdr_txn_int {
  extends: [daily_mdr_rollup]
  drill_fields: [subscriber_id, sub_info1.sub_name, service_datetime_date]
  dimension: id {primary_key: no hidden:yes}
  set: cols {
    fields: [
      subscriber_id,
      integration_point_name,
      service_datetime_raw,
      service_datetime_date,
      act_date_raw,
      act_date_date,
      sum_transactions,
      sum_device_transactions,
      sum_fp_transactions,
      sum_tp_transactions
    ]
  }

  dimension_group: act_date {
    type: time
    timeframes: [raw, date]
    sql: ${asof.act_date_raw} ;;
  }

}


#################################################
#   New 1st Party  Volume Alert
#################################################

explore: service_alert_new_first_party {
 # fields: [new_sub_list_fp.cols*]
  sql_always_where:  ${is_new} ;;
  extends: [sub_info]
  hidden: no
  join: new_sub_list {

    type: inner
    relationship: many_to_one
    sql_on: ${service_alert_new_first_party.subscriber_id} = ${new_sub_list.subscriber_id}
          AND ${service_alert_new_first_party.service_datetime_raw} = ${new_sub_list.act_date_raw};;

  }

  join: sub_info {
    sql_where: ${sub_info.is_status_active} ;;
    relationship: one_to_one
    type: inner
    sql_on: ${service_alert_new_first_party.subscriber_id} = ${sub_info.subscriber_id};;
  }


}

view: service_alert_new_first_party {
  extends: [daily_mdr_rollup]

  dimension: id {primary_key: no hidden:no}
  set: cols {
    fields: [
      subscriber_id,
      sum_transactions,
      sum_device_transactions,
      sum_fp_transactions,
      sum_tp_transactions,
      act_date_date,
      first_seen_date_date

    ]
  }

  dimension: subscriber_id {
    type: number


  }

  dimension_group: act_date {
    type: time
    timeframes: [raw, date]
    sql: ${new_sub_list.act_date_raw} ;;
  }

  dimension_group: first_seen_date {
    label: "First Transaction"
    type: time
    timeframes: [raw, date]
    sql: ${new_sub_list.first_seen_date_raw} ;;
  }

  dimension: is_new {
    type: yesno
    sql: ${first_seen_date_raw} > (${act_date_raw} - interval '14 days') ;;
  }


  dimension: is_on_act_time {
    type: yesno
    sql: ${service_datetime_raw} = ${act_date_raw} ;;
  }

  measure: current_transactions {
    type: number
    label: "Current Transaction Count"
    sql: ${sum_transactions} ;;

  }

  measure: current_device_transactions {
    type: number
    label: "Current Device Transaction Count"
    sql: ${sum_device_transactions} ;;

  }

  measure: current_fp_transactions {
    type: number
    label: "Current 1st Party Transaction Count"
    sql: ${sum_fp_transactions} ;;

  }

  measure: current_tp_transactions {
    type: number
    label: "Current 3rd Party Transaction Count"
    sql: ${sum_tp_transactions} ;;

  }


}


explore:new_sub_list  {hidden: yes
}

view: new_sub_list {
  derived_table: {
    explore_source: sub_list {
      column: subscriber_id {}
      column: act_date_date {}
      column: min_service_date {}
      bind_filters: {
        to_field: sub_list.subscriber_id
        from_field: new_sub_list.subscriber_id
      }

    }
  }

  dimension: is_new {
    type: yesno
    sql: ${first_seen_date_raw} > (${act_date_raw} - interval '14 days') ;;
  }

  dimension: is_on_act_time {
    type: yesno
    sql: ${service_datetime_raw} = ${act_date_raw} ;;
  }

  dimension: subscriber_id {
    type: number
    sql: ${TABLE}.subscriber_id ;;

  }

  dimension_group: service_datetime {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.service_datetime_date ;;
  }

  dimension_group: act_date {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.act_date_date ;;
  }

  dimension_group: first_seen_date {
    type: time
    timeframes: [raw, date]
    sql:  ${TABLE}.min_service_date ;;
  }




}

explore: sub_list {
  fields: [sub_list.cols*]
  hidden: yes
  join: asof {
    from: daily_mdr_max_ts
    type: cross
    relationship: many_to_one
    sql_where:
      ${sub_list.service_datetime_raw} >= ${asof.act_date_raw} - INTERVAL '60 days'
      AND (${sub_list.fp_only_cnt} + ${sub_list.both_present_cnt} ) > 0
    ;;
  }


}



view: sub_list {
  extends: [daily_mdr_rollup]

  dimension: id {primary_key: no hidden:no}
  set: cols {
    fields: [
      subscriber_id,
      act_date_raw,
      act_date_date,
      min_service_date

    ]
  }



  dimension_group: act_date {
    type: time
    timeframes: [raw, date]
    sql: ${asof.act_date_raw} ;;
  }

  dimension_group: first_seen_date {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.min_service_date ;;
  }




}


#################################################
#   New INTLOC  Volume Alert
#################################################



explore: service_alert_new_intloc {
  fields: [service_alert_new_intloc.cols*, sub_info*, salesforce*]
  sql_always_where:  ${is_new} ;;
  extends: [sub_info]
  hidden: no
  join: new_intloc_list {

    type: inner
    relationship: many_to_one
    sql_on: ${service_alert_new_intloc.subscriber_id} = ${new_intloc_list.subscriber_id}
      AND ${service_alert_new_intloc.service_datetime_raw} = ${new_intloc_list.act_date_raw}
      AND ${service_alert_new_intloc.intloc} = ${new_intloc_list.intloc};;

    }

    join: sub_info {
      sql_where: ${sub_info.is_status_active} ;;
      relationship: one_to_one
      type: inner
      sql_on: ${service_alert_new_intloc.subscriber_id} = ${sub_info.subscriber_id};;
    }
  }

  view: service_alert_new_intloc {
    extends: [daily_mdr_rollup]

    dimension: id {primary_key: no hidden:no}
    set: cols {
      fields: [
        subscriber_id,
        intloc,
        current_transactions,
        act_date_date,
        first_seen_date_date

      ]
    }

    dimension: subscriber_id {
      label: "Sub Code"
      type: number
    }



    dimension: intloc {
      label: "INTLOC"
      type: string
    }

    dimension_group: act_date {
      type: time
      timeframes: [raw, date]
      sql: ${new_intloc_list.act_date_raw} ;;
    }

    dimension_group: first_seen_date {
      label: "Intloc Begin Date"
      type: time
      timeframes: [raw, date]
      sql: ${new_intloc_list.first_seen_date_date} ;;
    }

    dimension: is_new {
      type: yesno
      sql: ${first_seen_date_raw} > (${act_date_raw} - interval '14 days') ;;
    }


    dimension: is_on_act_time {
      type: yesno
      sql: ${service_datetime_raw} = ${act_date_raw} ;;
    }

    measure: current_transactions {
      type: number
      label: "Current Transaction Count"
      sql: ${sum_txn_cnt} ;;

    }
  }


  explore:new_intloc_list  {hidden: yes
  }

  view: new_intloc_list {
    derived_table: {
      explore_source: intloc_list {
        column: subscriber_id {}
        column: intloc {}
        column: act_date_date {}
        column: min_service_date {}


      }
    }

    dimension: is_new {
      type: yesno
      sql: ${first_seen_date_raw} > (${act_date_raw} - interval '14 days') ;;
    }

    dimension: is_on_act_time {
      type: yesno
      sql: ${service_datetime_raw} = ${act_date_raw} ;;
    }

    dimension: subscriber_id {
      type: number
      sql: ${TABLE}.subscriber_id ;;

    }

    dimension: intloc {
      type: string
      sql: ${TABLE}.intloc ;;

    }

    dimension_group: service_datetime {
      type: time
      timeframes: [raw, date]
      sql: ${TABLE}.service_datetime_date ;;
    }

    dimension_group: act_date {
      type: time
      timeframes: [raw, date]
      sql: ${TABLE}.act_date_date ;;
    }

    dimension_group: first_seen_date {
      type: time
      timeframes: [raw, date]
      sql:  ${TABLE}.min_service_date ;;
    }




  }

  explore: intloc_list {
    fields: [intloc_list.cols*]
    hidden: yes
    join: asof {
      from: daily_mdr_max_ts
      type: cross
      relationship: many_to_one
      sql_where:
      ${intloc_list.service_datetime_raw} >= ${asof.act_date_raw} - INTERVAL '60 days'

    ;;
    }


  }



  view: intloc_list {
    extends: [daily_mdr_rollup]

    dimension: id {primary_key: no hidden:no}
    set: cols {
      fields: [
        subscriber_id,
        intloc,
        act_date_raw,
        act_date_date,
        min_service_date
      ]
    }



    dimension_group: act_date {
      type: time
      timeframes: [raw, date]
      sql: ${asof.act_date_raw} ;;
    }



  }
