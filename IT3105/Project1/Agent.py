from actor import Actor, decode_action
from critic_table import CriticTable
from critic_nn import CriticNN


class Agent:

    def __init__(self, critic_mode: str, actor_discount_factor: float, e_greedy_rate: float, actor_learning_rate: float,
                 e_greedy_decay_rate: float, critic_learning_rate: float, critic_discount_factor,
                 actor_eligibility_decay_rate: float, critic_eligibility_decay_rate: float, nn_dimensions, state_size,
                 model_fp, pretrained: bool):

        self.actor = Actor(discount_factor=actor_discount_factor,
                           e_greedy_rate=e_greedy_rate,
                           lr=actor_learning_rate,
                           e_greedy_decay_rate=e_greedy_decay_rate,
                           actor_eligibility_decay_rate=actor_eligibility_decay_rate,
                           )

        if critic_mode == "nn":
            self.critic = CriticNN(method=critic_mode,
                                   lr=critic_learning_rate,
                                   critic_eligibility_decay_rate=critic_eligibility_decay_rate,
                                   discount_factor=critic_discount_factor,
                                   nn_dimensions=nn_dimensions,
                                   input_size=state_size,
                                   model_fp=model_fp,
                                   pretrained=pretrained)

        elif critic_mode == "table":
            self.critic = CriticTable(method=critic_mode,
                                      lr=critic_learning_rate,
                                      critic_eligibility_decay_rate=critic_eligibility_decay_rate,
                                      discount_factor=critic_discount_factor,
                                      input_size=state_size)
        else:
            raise ValueError()

    def episode(self):
        # at end of each episode, modify e_greedy
        pass

    def time_step(self, new_state, reinforcement, all_availiable_actions,
                  last_step_of_ep: bool):  # gets from game: reinforcement, old state, new state, action and all
        # available actions

        # Actor Job 1: find next action according to policy
        if not last_step_of_ep:  # Dont think the if-statement is necessary
            new_action = self.actor.get_new_action_on_new_state(new_state, all_availiable_actions)

        # Actor Job 2: set eligibility of last state as this last state is the one affected by td_error.
        assert self.actor.set_elegibility_of_last_state_action()

        # Critic Job 1: Calculate TD Error
        delta = self.critic.calculate_td_error(new_state=new_state, reinforcement=reinforcement)

        # Critic Job 2: Set state
        self.critic.set_current_eligibility()

        # Critic Job 3: iterate and update all values and eligibilities of states in episode_trace
        self.critic.update_episode_states(delta)

        self.actor.update_policy_of_episode_sa_pairs(delta)

        if last_step_of_ep:
            return

        self.actor.update_episode_eligibilities()

        # Last actor action: save action into trace, restate a as a= a'
        self.actor.restate_action(new_state=new_state, action_on_new_state=new_action)

        # Save state into trace
        self.critic.ordered_states.append(new_state)

        return decode_action(new_action)

    def reset_elegibilities(self):
        self.critic.reset_eligibilities()
        self.actor.reset_eligibilities()
        self.critic.ordered_states = []
        self.actor.ordered_state_action = []
        return True

    def initialize_state_and_action(self, state, available_moves):
        self.critic.ordered_states.append(state)
        action = self.actor.get_new_action_on_new_state(state, available_moves)
        self.actor.ordered_state_action.append((state, action))
        return decode_action(action)
