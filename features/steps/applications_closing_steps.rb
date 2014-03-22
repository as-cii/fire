Then(/^"(.*?)" process should not exist$/) do |process|
  expect_process_not_running(process)
end

def expect_process_not_running(process)
  is_running = `ps | grep #{process}`.lines.reject { |line| line.include?('grep') }.any?
  expect(is_running).to be_false
end
