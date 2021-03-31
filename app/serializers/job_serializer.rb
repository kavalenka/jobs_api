# frozen_string_literal: true

class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :rate_per_hour, :languages
end
