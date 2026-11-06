{% if snake_case_section_title == "education" %}
#v(0.7em)
#grid(columns: (1fr, 1fr), column-gutter: 2em, [
#set par(spacing: 0.3em)
{% elif snake_case_section_title == "languages" %}
], [
#set par(spacing: 0.3em)
{% endif %}
== {{section_title}}
{% if entry_type in ["ReversedNumberedEntry"] %}

#reversed-numbered-entries(
  [
{% endif %}
