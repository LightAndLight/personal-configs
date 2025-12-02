lines |
each { |url|
  let title = (curl err> /dev/null -L $url | pup 'title text{}')
  $"[($title)]\(($url)\)"
} |
to text
