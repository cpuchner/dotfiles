; extends
(
(raw_string_literal) @sql
(#match? @sql "\\s*(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP|WITH|select|insert|update|delete|create|alter|drop|with)\\s+")
(#set! injection.language "sql")
)
