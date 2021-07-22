require "metagem/engine"

module Metagem
  extend self

  attr_writer :use_active_admin

  def use_active_admin
    return true unless @use_active_admin

    !!@use_active_admin
  end

  def setup
    yield self
    require "metagem"
  end
end
