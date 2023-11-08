
view: new_sql_dt_from__service_alert_new_intloc {
  derived_table: {
    sql: SELECT
          intloc,
          AVG(CAST(is_new AS NUMBER)) AS avg_is_new
      FROM
          service_alert_new_intloc
      GROUP BY
          intloc ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: intloc {
    type: string
    sql: ${TABLE}."INTLOC" ;;
  }

  dimension: avg_is_new {
    type: number
    sql: ${TABLE}."AVG_IS_NEW" ;;
  }

  set: detail {
    fields: [
        intloc,
	avg_is_new
    ]
  }
}
