---
name: marketing-automation
description: >
  Review and evaluate Salekit marketing automation: workflows, sequences (email/message series), funnels
  and campaign suggestions. Use when the user asks which workflows are running, whether a sequence works,
  failed emails, funnel conversion, which step customers are at, or what campaign to run, e.g.
  "workflow nào đang chạy", "sequence chăm sóc hiệu quả không", "email gửi lỗi", "funnel chuyển đổi thế nào",
  "nên chạy chiến dịch gì".
metadata:
  version: "0.2.0"
---

# Marketing automation

## Workflows

- List: `get_workflows`. Details and configuration: `get_workflow_detail`; step diagram: `get_workflow_canvas`.
- Performance: `get_workflow_stats` (overview), `get_workflow_node_stats` (per step), `get_workflow_report` (over time).
- Customers in a workflow: `get_workflow_customers`. Email log: `get_workflow_email_logs`.
- `get_workflow_lookups` returns reference values (step types, statuses...) needed to read the other tools' results correctly.

When evaluating a workflow: briefly describe the flow from the canvas (what triggers it, what it sends, how long it waits), then point out the step with the biggest drop-off from `get_workflow_node_stats` and the send-failure rate from the email log.

## Sequences

- `get_sequences`, `get_sequence_detail` for each message's content; `get_sequence_stats` for sent, open and click rates; `get_sequence_sent_list` for the sent list.
- Compare messages within a sequence to find the weakest one, and suggest a better subject line or send time.

## Funnels

- `get_funnels`, `get_funnel_detail`, together with `get_conversion_rate`.
- Present step by step: people entering, people reaching the next step, rate. Lead with the step that loses the most.

## Campaign suggestions

`recommend_campaign` gives campaign suggestions. Combine with `detect_customer_churn` (customers about to churn) or `get_customer_tags` / `get_tags` to propose a target group. Each proposal covers: customer group, message, channel, estimated audience size.

## Limits

Read and analyze only. Activating, pausing or editing a workflow, or adding customers to a sequence, affects real customers: if a write tool exists, summarize the action and wait for the user's confirmation; if not, direct them to Salekit.
