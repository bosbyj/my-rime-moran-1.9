local kReject = 0
local kAccepted = 1
local kNoop = 2
local function user_dot_commit_processor(key_event, env)

  -- 检测句点键（keycode 0x2E）且未释放
  if key_event.keycode ~= 0x2E or key_event:release() then
    return kNoop
  end

  --   -- 检测逗号键（keycode 0x2C）且未释放
  -- if key_event.keycode ~= 0x2C or key_event:release() then
  --   return kNoop
  -- end

  local context = env.engine.context
  local input = context.input
  local composition = context.composition

  -- 检查是否在编辑状态（compose）
  if composition:empty() then
    return kNoop
  end

  -- 只在输入长度为 4 时触发
  if #input ~= 4 then
    -- 模拟按数字键1
    env.engine:process_key(KeyEvent("1"))
    return kAccepted
  end

  -- -- 模拟按斜杠键(/)
  -- 模拟按逗号
  env.engine:process_key(KeyEvent(","))
  -- 模拟按数字键1
  env.engine:process_key(KeyEvent("1"))
  -- 返回 kAccepted 阻止原始句点键的处理
  return kAccepted
end
return user_dot_commit_processor
