class HomesController < ApplicationController
  before_action :set_data
  before_action :set_graph_data, only: [:base_design_2, :design_2, :graph_data]

  def index
  end

  def base_design_1
  end

  def base_design_2
  end

  def design_1
  end

  def design_2
  end

  def graph_data
    render json: @graphs[params[:id].to_i]
  end

  private
  def set_data
    @data = [
      {
        "AA" => [0, 111, 41, 0, 0, 0, 0],
        "AB" => [83, 0, 105, 0, 0, 0, 0],
        "AC" => [45, 86, 0, 63, 0, 0, 0],
        "AD" => [0, 0, 33, 0, 85, 32, 43],
        "AE" => [0, 0, 0, 66, 0, 102, 26],
        "AF" => [0, 0, 0, 39, 77, 0, 83],
        "AG" => [0, 0, 0, 37, 45, 62, 0]
      },
      {
        "AH" => [0, 0, 52, 112, 0, 39, 0],
        "AI" => [0, 0, 0, 0, 35, 43, 56],
        "AJ" => [48, 0, 0, 79, 56, 0, 0],
        "AK" => [86, 0, 103, 0, 0, 0, 0],
        "AL" => [0, 28, 32, 0, 0, 38, 95],
        "AM" => [65, 33, 0, 0, 41, 0, 40],
        "AN" => [0, 77, 0, 0, 72, 28, 0]
      },
      {
        "AO" => [0, 43, 63, 0, 0, 39, 0],
        "AP" => [47, 0, 96, 33, 0, 0, 0],
        "AQ" => [41, 91, 0, 0, 0, 55, 0],
        "AR" => [0, 66, 0, 0, 67, 48, 32],
        "AS" => [0, 0, 0, 100, 0, 31, 66],
        "AT" => [55, 0, 31, 26, 33, 0, 20],
        "AU" => [0, 0, 0, 33, 106, 37, 0]
      },
      {
        "AV" => [0, 0, 91, 36, 0, 40, 25],
        "AW" => [0, 0, 0, 33, 104, 48, 0],
        "AX" => [62, 0, 0, 31, 0, 0, 35],
        "AY" => [41, 64, 38, 0, 0, 0, 41],
        "AZ" => [0, 75, 0, 0, 0, 47, 59],
        "BA" => [70, 57, 0, 0, 45, 0, 34],
        "BB" => [32, 0, 39, 39, 30, 66, 0]
      },
      {
        "BC" => [0, 2, 110, 4, 6, 7, 37],
        "BD" => [7, 0, 3, 85, 28, 41, 37],
        "BE" => [87, 6, 0, 7, 74, 6, 35],
        "BF" => [9, 62, 5, 0, 31, 29, 4],
        "BG" => [3, 33, 36, 28, 0, 80, 8],
        "BH" => [7, 28, 5, 21, 66, 0, 58],
        "BI" => [31, 60, 32, 5, 4, 39, 0]
      },
      {
        "BJ" => [0, 37, 5, 39, 6, 7, 66],
        "BK" => [38, 0, 39, 112, 3, 7, 2],
        "BL" => [3, 57, 0, 6, 57, 39, 27],
        "BM" => [34, 70, 3, 0, 9, 5, 7],
        "BN" => [3, 6, 88, 7, 0, 61, 29],
        "BO" => [4, 7, 30, 5, 88, 0, 61],
        "BP" => [35, 3, 29, 5, 26, 97, 0]
      }
    ]

    @colors = {
      0 => [239, 114, 103],
      1 => [239, 114, 103],
      2 => [239, 114, 103],
      3 => [239, 114, 103],
      4 => [239, 114, 103],
      5 => [239, 114, 103],
      6 => [239, 114, 103]
    }

    @receivers = @data.map do |group|
      result = {}
      group.keys.each do |key|
        result.update(key => []);
        group[key].each_with_index do |no_messages, receiver_index|
          result[key] << group.keys[receiver_index] if no_messages > 0
        end
      end
      result
    end

    @senders = @data.map do |group|
      result = {}
      group.keys.each_with_index do |key, receiver_index|
        result.update(key => []);
        group.keys.each do |sender|
          result[key] << sender if group[sender][receiver_index] > 0
        end
      end
      result
    end
    # @senders.each do |group|
    #   group.each do |receiver, senders_of_receiver|
    #     senders_of_receiver.each do |sender|
    #       group[receiver] += group[sender]
    #       group[receiver].uniq
    #     end
    #   end
    # end
  end

  def set_graph_data
    @graphs = @data.map do |group|
      graph = { nodes: [], links: []}
      group.keys.each_with_index { |key, index| graph[:nodes] << { id: key, group: index } }
      group.keys.each_with_index do |sender, sender_index|
        group[sender].each_with_index do |no_messages, receiver_index|
          graph[:links] << {
            source: sender,
            target: group.keys[receiver_index],
            value: no_messages
          } if no_messages > 0
        end
      end
      graph
    end
  end
end
