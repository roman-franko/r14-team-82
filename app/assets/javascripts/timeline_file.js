  $(document).ready(function() {
    createStoryJS({
      type: 'timeline',
      width: '400',
      height: '500',
      source: '/events.json', //get the events.json format from https://github.com/VeriteCo/TimelineJS#file-formats
      embed_id: 'time_line'
    });
  });