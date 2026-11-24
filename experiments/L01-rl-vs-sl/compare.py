"""第 01 讲配套实验：随机策略 vs 规则策略（CartPole-v1）。

目的：建立一个基线锚点——
  1. 随机策略告诉我们"什么都没学"时的回报水平；
  2. 规则策略告诉我们"一点点领域知识"能把回报推到多高；
  3. 后面的 DQN（第 10 讲）要拿这两个数字做参照系。

运行：python compare.py
输出：results.csv、return_curves.png（写入本目录）
"""
import csv
from pathlib import Path

import gymnasium as gym
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

# Windows 中文字体，避免标题/图例变方块
plt.rcParams["font.sans-serif"] = ["Microsoft YaHei", "SimHei"]
plt.rcParams["axes.unicode_minus"] = False

ENV_NAME = "CartPole-v1"
N_EPISODES = 100
SEED = 42
OUT_DIR = Path(__file__).resolve().parent


def run_random_policy(n_episodes=N_EPISODES, seed=SEED):
    """每个动作等概率随机采样——'什么都没学'的基线。"""
    env = gym.make(ENV_NAME)
    env.action_space.seed(seed)
    rng = np.random.default_rng(seed)
    returns = []
    for ep in range(n_episodes):
        obs, info = env.reset(seed=seed + ep)
        total = 0.0
        done = False
        while not done:
            # 用 rng 而不是 env.action_space.sample()，保证两次运行结果完全一致
            action = int(rng.integers(0, env.action_space.n))
            obs, reward, terminated, truncated, info = env.step(action)
            total += reward
            done = terminated or truncated
        returns.append(total)
    env.close()
    return np.asarray(returns, dtype=float)


def run_rule_policy(n_episodes=N_EPISODES, seed=SEED):
    """手写规则：杆往哪边倒就往哪边推，同时兼顾小车位置。

    这不是'学习'出来的策略，而是把人类对物理的 understood 直接写进去——
    后面 DQN 要从交互中自己学到类似的行为。
    """
    env = gym.make(ENV_NAME)
    returns = []
    for ep in range(n_episodes):
        obs, info = env.reset(seed=seed + ep)
        total = 0.0
        done = False
        while not done:
            x, x_dot, theta, theta_dot = obs
            # 经典启发式：角度主导，角速度次之，位置做小幅修正
            action = 1 if (theta + 0.3 * theta_dot + 0.05 * x + 0.02 * x_dot) > 0 else 0
            obs, reward, terminated, truncated, info = env.step(action)
            total += reward
            done = terminated or truncated
        returns.append(total)
    env.close()
    return np.asarray(returns, dtype=float)


def moving_average(values, window=10):
    """简单滑动平均，让曲线可读（不参与统计）。"""
    kernel = np.ones(window) / window
    return np.convolve(values, kernel, mode="valid")


def summarize(name, returns):
    return {
        "策略": name,
        "平均回报": f"{returns.mean():.2f}",
        "标准差": f"{returns.std():.2f}",
        "最小值": f"{returns.min():.2f}",
        "最大值": f"{returns.max():.2f}",
    }


def main():
    random_returns = run_random_policy()
    rule_returns = run_rule_policy()

    print(f"[{ENV_NAME}] {N_EPISODES} 局，seed={SEED}")
    for row in (summarize("随机策略", random_returns), summarize("规则策略", rule_returns)):
        print("  " + "  ".join(f"{k}={v}" for k, v in row.items()))

    # 保存原始数据，供讲义/文章引用，也便于复算
    with open(OUT_DIR / "results.csv", "w", newline="", encoding="utf-8-sig") as f:
        writer = csv.writer(f)
        writer.writerow(["episode", "random_return", "rule_return"])
        for i, (r, u) in enumerate(zip(random_returns, rule_returns), start=1):
            writer.writerow([i, f"{r:.0f}", f"{u:.0f}"])

    # 曲线：浅色原始 + 深色滑动平均，符合"图为主、字为辅"
    fig, ax = plt.subplots(figsize=(9, 4.5), dpi=150)
    ax.plot(random_returns, alpha=0.25, color="#d62728", linewidth=0.8)
    ax.plot(moving_average(random_returns), color="#d62728", linewidth=2,
            label=f"随机策略（均值 {random_returns.mean():.2f}）")
    ax.plot(rule_returns, alpha=0.25, color="#1f77b4", linewidth=0.8)
    ax.plot(moving_average(rule_returns), color="#1f77b4", linewidth=2,
            label=f"规则策略（均值 {rule_returns.mean():.2f}）")
    ax.axhline(500, color="gray", linestyle="--", linewidth=1, label="环境上限 500")
    ax.set_xlabel("回合（episode）")
    ax.set_ylabel("回报（存活步数）")
    ax.set_title("CartPole-v1：随机策略 vs 规则策略（10 回合滑动平均）")
    ax.legend(loc="lower right", fontsize=9)
    ax.grid(alpha=0.3)
    fig.tight_layout()
    fig.savefig(OUT_DIR / "return_curves.png", bbox_inches="tight")
    plt.close(fig)
    print(f"已保存：{OUT_DIR / 'results.csv'}")
    print(f"已保存：{OUT_DIR / 'return_curves.png'}")


if __name__ == "__main__":
    main()
