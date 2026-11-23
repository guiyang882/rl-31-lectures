"""CartPole 随机策略基线 —— 第 01 讲配套实验。"""
import gymnasium as gym
import numpy as np


def run_random_policy(env_name="CartPole-v1", n_episodes=100, seed=42):
    """运行随机策略，返回每回合回报。"""
    env = gym.make(env_name)
    rng = np.random.default_rng(seed)
    env.action_space.seed(seed)
    returns = []

    for _ in range(n_episodes):
        state, info = env.reset(seed=seed)
        total_reward = 0.0
        terminated = truncated = False
        while not (terminated or truncated):
            action = env.action_space.sample()
            state, reward, terminated, truncated, info = env.step(action)
            total_reward += reward
        returns.append(total_reward)

    env.close()
    return np.array(returns)


if __name__ == "__main__":
    returns = run_random_policy()
    print(f"平均回报: {returns.mean():.2f}")
    print(f"标准差:   {returns.std():.2f}")
