
class DefaultRefreshLocal {

  static DefaultRefreshLocal en({
    String loading: "loading...",
    String error: 'load error...',
    String pullDownToRefresh: "pull down to refresh",
    String pullUpToRefresh: "pull up to refresh",
    String releaseToRefresh: "release to refresh",
    String lastUpdate = "last update"}) =>

    DefaultRefreshLocal(
      error: error,
      lastUpdate: lastUpdate,
      loading: loading,
      releaseToRefresh: releaseToRefresh,
      pullDownToRefresh: pullDownToRefresh,
      pullUpToRefresh: pullUpToRefresh
    );

  static DefaultRefreshLocal zh({
    String loading: "加载中...",
    String error: "加载失败...",
    String pullDownToRefresh: "下拉刷新",
    String pullUpToRefresh: "上拉加载更多",
    String releaseToRefresh: "放开加载",
    String lastUpdate = "最后更新"}) =>
    
    DefaultRefreshLocal(
      error: error,
      lastUpdate: lastUpdate,
      loading: loading,
      releaseToRefresh: releaseToRefresh,
      pullDownToRefresh: pullDownToRefresh,
      pullUpToRefresh: pullUpToRefresh
    );

  final String loading;
  final String pullDownToRefresh;
  final String pullUpToRefresh;
  final String releaseToRefresh;
  final String lastUpdate;
  final String error;

  const DefaultRefreshLocal({
    this.lastUpdate,
    this.error,
    this.loading,
    this.pullUpToRefresh,
    this.pullDownToRefresh,
    this.releaseToRefresh
  });
}