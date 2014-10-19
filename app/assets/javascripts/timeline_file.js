$(document).ready(function() {
  var d = new Date();
  var today = d.getFullYear().toString() + "," + (d.getMonth() +1 ).toString() + "," + d.getDate().toString()
  
  timeline = {
      "timeline":
       {
           "headline":"Chronoscope",
           "type":"default",
            "text":"Try it!",
            "startDate":today,
            "asset":
              {
                  "media":"/time-1.jpg",
                  "credit":"",
                  "caption":""
              },
           "date": [
               {
                   "startDate":today,
                   "headline":"Great day",
                   "text":"<p>for experiments with chronoscope</p>",
                   "asset":
                   {
                       "media":"/time-2.jpg",
                       "credit":"",
                       "caption":""
                   }
               },
            ]
       }
  };



    $('.show-chronology').click(function() {
      keywords = $('#timeline form textarea').val();
      document.body.style.cursor  = 'wait';

      $.post('requests',
             { request_string:keywords },
             function(data) {
                document.body.style.cursor  = 'default';
                if (data) {
                      var timeline = {
                        "timeline":
                         {
                         "headline":"Results for",
                         "type":"default",
                         "text":keywords ,
                         "startDate":"2012,1,26",
                         "asset":
                            {
                                "media":"/time-1.jpg",
                                "credit":"",
                                "caption":""
                            },
                             "date": [ ]
                         }
                      };

                  timeline.timeline.date =  $.parseJSON(data);

                  $("#time_line").empty();

                  createStoryJS({
                    type: 'timeline',
                    width: '100%',
                    height: '500',
                    source:  timeline,
                    embed_id: 'time_line'
                  });
                }
             },
             'json'
           );

      return false; // avoid to execute the actual submit of the form.

    });


    createStoryJS({
      type: 'timeline',
      width: '100%',
      height: '500',
      font: 'Lekton-Molengo',
      source: timeline, //get the events.json format from https://github.com/VeriteCo/TimelineJS#file-formats
      embed_id: 'time_line'
    });

});
