local cmp = require("cmp")
local source = {}

source.complete = function(_, _, callback)
   local handle = io.popen("uuidgen")
   if handle == nil then
       return
   end

   local result = handle:read("*a")
   handle:close()

   if result == nil then
       return
   end

   callback({
       items = {
           {
               label = "generate uuid",
               word = string.lower(result),
               detail = "Generates a UUID and inserts it into the buffer.",
               kind = cmp.lsp.CompletionItemKind.Snippet,
           },
       },
   })
end

source.is_available = function()
   return true
end

return source
