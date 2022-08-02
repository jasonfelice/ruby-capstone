require 'date'
require_relative './label'

class Item
  attr_reader :archived, :label, :author, :publish_date, :genre

  def initialize(*)
    @id = Random.rand(1..1000)
    @genre = nil
    @author = nil
    @label = nil
    @publish_date = Date.today
    @archived = false
  end

  def add_label(label)
    label.is_a?(Label) && @label.nil? && (
      @label = label
      label.add_item(self)
    )
  end

  def add_genre(genre)
    genre.is_a?(Genre) && @genre.nil? && (
      @genre = genre
      genre.add_item(self)
    )
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    (Date.today - Date.parse(@publish_date)).to_i > 365 * 10
  end
end
