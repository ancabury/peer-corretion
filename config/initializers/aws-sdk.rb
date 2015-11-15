# AWS.config[:credentials] = AWS::Credentials.new(
#   ENV['BUCKETEER_AWS_ACCESS_KEY_ID'],
#   ENV['BUCKETEER_AWS_SECRET_ACCESS_KEY'])

# AWS.config[:credentials] = new AWS.Credentials(
#   ENV['BUCKETEER_AWS_ACCESS_KEY_ID'],
#   ENV['BUCKETEER_AWS_SECRET_ACCESS_KEY'])

# AWS.config[:region]      = 'us-east-1'

AWS.config({
  :access_key_id => ENV['BUCKETEER_AWS_ACCESS_KEY_ID'],
  :secret_access_key => ENV['BUCKETEER_AWS_SECRET_ACCESS_KEY'],
  :region => 'us-west-2',
})

S3 = AWS::S3::Client.new
