FactoryGirl.define do
  sequence(:author) { |n| "John Doe #{n}" }

  factory :comment do
    author
    comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras faucibus rutrum urna, vel tincidunt elit lacinia eget. Donec magna lectus, vulputate eget varius cursus, condimentum nec erat. Duis facilisis leo nibh, at fermentum purus. Donec dignissim neque id velit scelerisque id rhoncus est malesuada. Pellentesque elit risus, faucibus vel vulputate eget, malesuada eu tortor. Donec vulputate pretium odio, id congue velit consectetur in. Fusce lobortis ultrices elementum. Suspendisse potenti."
    job
  end
end
