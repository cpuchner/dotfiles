; extends
(
(raw_string_literal) @sql
(#match? @sql "\\s*(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP|select|insert|update|delete|create|alter|drop)\\s+")
(#not-match? @sql "\\s*(WITH|with)\\s+")
(#set! injection.language "sql")
)
