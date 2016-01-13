$(function() {
  var location = window.history.location || window.location;
  $(document).on('click', 'a.ajax', function() {
    history.pushState(null, null, this.href);
    load(this.href);
    return false;
  });

  function load(href) {
    NProgress.start();
    var path = href.split('#');
    if (path.count == 2) {
      path = path[1];
    } else {
      path = 'posts';
    }

    $.getJSON('/api/v1/' + path, null, renderPosts)
    .fail(function() {
      // TODO: show 404.
    })
    .always(function() {
      NProgress.done();
    });
  }

  function renderPosts(json) {
    var posts;
    if (json['posts'] != undefined) {
      posts = json['posts'];
    } else if (json['id'] != undefined) {
      posts = [json];
    }
    $('#posts').empty();
    for (var i=0; i<posts.length; i++) {
      var post = posts[i];
      var postTemplate = $('#postTemplate').clone();
      postTemplate.removeAttr('id');
      postTemplate.removeAttr('style');
      // postTemplate.find('.post-title a')
      // TODO: Render author:
      postTemplate.find('.post-meta').first().html(post['created']);

      var content = post['content'];
      var markdown = new showdown.Converter().makeHtml(content);
      postTemplate.find('.post-content').first().html(markdown);
      $('#posts').append(postTemplate);
    }
  }

  load("posts");
});
