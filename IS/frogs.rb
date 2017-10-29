module Frogs

  POSSIBLE_STEPS = [-2, -1, 1, 2]

  class << self

    def solve
      print 'Enter the number of frogs per side: '

      free_rock = frogs_per_side = gets.to_i

      state = start_state(frogs_per_side)

      rec(state, free_rock, [state]).each { |state| p state.join('') }
    end

    def rec(state, free_rock, states)
      next_states(state, free_rock).each do |state_info|
        break if @solution

        new_state, next_rock_position = state_info

        new_states = states.clone
        new_states << new_state

        solution(new_states) if new_state == end_state
        next if dead_end?(new_state)

        rec(new_state, next_rock_position, new_states)
      end

      @solution
    end

    def next_states(current_state, free_rock)
      [].tap do |states_info|
        POSSIBLE_STEPS.each do |step|
          next_rock_position = free_rock + step

          next if next_rock_position < 0 || next_rock_position >= current_state.size
          next if step > 0 && current_state[next_rock_position] == '>'
          next if step < 0 && current_state[next_rock_position] == '<'

          states_info << [current_state.swap(free_rock, next_rock_position), next_rock_position]
        end
      end
    end

    def dead_end?(state)
      state.join('') =~ /.+<<_>>.+|^_>>.+|^<_>>.+|.+<<_>$|.+<<_$/
    end

    def start_state(frogs_per_side)
      @start_state ||= ('>' * frogs_per_side + '_' + '<' * frogs_per_side).chars
    end

    def end_state
      @end_state ||= @start_state.reverse
    end

    def solution(states)
      @solution ||= states
    end
  end
end

class Array
  def swap(a, b)
    result = self.clone
    result[a], result[b] = result[b], result[a]
    result
  end
end

Frogs::solve
