import networkx as nx
import time


if __name__ == "__main__":
    G = nx.DiGraph(name="asia")
    G.add_edges_from(
        [
            ("asia", "tuberculosis"),
            ("smoking", "cancer"),
            ("smoking", "bronchitis"),
            ("tuberculosis", "either"),
            ("cancer", "either"),
            ("either", "xray"),
            ("either", "dyspnea"),
            ("bronchitis", "dyspnea"),
        ]
    )
    nx.freeze(G)
    count = 100000

    t1 = time.time_ns()
    for _ in range(count):
        nx.d_separated(
            G, {"asia", "smoking"}, {"dyspnea", "xray"}, {"bronchitis", "either"}
        )
    dt1 = time.time_ns() - t1
    dt1 /= count * 1000

    t1 = time.time_ns()
    for _ in range(count):
        nx.d_separated(
            G, {"tuberculosis", "cancer"}, {"bronchitis"}, {"smoking", "xray"}
        )
    dt2 = time.time_ns() - t1
    dt2 /= count * 1000

    print("test1: %.2f us" % dt1)
    print("test2: %.2f us" % dt2)
