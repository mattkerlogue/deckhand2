# check CSS generation

    Code
      cat(generate_deckhand_css())
    Output
      @import url('https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,500;1,500&display=swap');
      
      :root {
        --colour-headings: #0F36C7;
        --colour-body: #0C0C0C;
        --colour-primary: #0F36C7;
        --colour-dark-grey: #666666;
        --colour-dark-gray: #666666;
        --colour-light-grey: #CCCCCC;
        --colour-light-gray: #CCCCCC;
        --color-headings: #0F36C7;
        --color-body: #0C0C0C;
        --color-primary: #0F36C7;
        --color-dark-grey: #666666;
        --color-dark-gray: #666666;
        --color-light-grey: #CCCCCC;
        --color-light-gray: #CCCCCC;
        --color-white: #ffffff;
        --colour-accent-1: #40ADFE;
        --colour-accent-2: #FFEC1C;
        --colour-accent-3: #8AC755;
        --colour-accent-4: #FF144C;
        --color-accent-1: #40ADFE;
        --color-accent-2: #FFEC1C;
        --color-accent-3: #8AC755;
        --color-accent-4: #FF144C
      }
      
      h1, h2, h3, h4, h5, h6 {
        font-family: 'Open Sans', sans-serif;
        font-weight: 500;
        color: var(--colour-headings);
        margin: 0px;
        padding: 0px;
      }
      
      h1 {
        font-size: 24pt;
      }
      
      h2, h3, h4, h5, h6 {
        font-size: 10pt;
        margin-top: 6pt;
      }
      
      body, p {
        font-family: 'Georgia', serif;
        font-weight: 300;
        font-size: 10pt;
        color: var(--colour-body);
      }
      
      p {
        margin-bottom: 6pt;
      }
      
      .text-primary {
        color: var(--colour-primary);
      }
      
      .bg-primary {
        background-color: var(--colour-primary);
      }
      
      .text-light-grey {
        color: var(--colour-light-grey);
      }
      
      .bg-light-grey {
        background-color: var(--colour-light-grey);
      }
      
      .text-light-gray {
        color: var(--colour-light-gray);
      }
      
      .bg-light-gray {
        background-color: var(--colour-light-gray);
      }
      
      .text-dark-grey {
        color: var(--colour-dark-grey);
      }
      
      .bg-dark-grey {
        background-color: var(--colour-dark-grey);
      }
      
      .text-dark-gray {
        color: var(--colour-dark-gray);
      }
      
      .bg-dark-gray {
        background-color: var(--colour-dark-gray);
      }
      
      .text-white {
        color: var(--colour-white);
      }
      
      .bg-white {
        background-color: var(--colour-white);
      }
      
      .draft {
        border: 1px solid var(--colour-light-grey);
      }
      
      .text-colour-accent-1 {
        color: var(--colour-accent-1);
      }
      
      .bg-colour-accent-1 {
        background-color: var(--colour-accent-1);
      }
      
      .text-colour-accent-2 {
        color: var(--colour-accent-2);
      }
      
      .bg-colour-accent-2 {
        background-color: var(--colour-accent-2);
      }
      
      .text-colour-accent-3 {
        color: var(--colour-accent-3);
      }
      
      .bg-colour-accent-3 {
        background-color: var(--colour-accent-3);
      }
      
      .text-colour-accent-4 {
        color: var(--colour-accent-4);
      }
      
      .bg-colour-accent-4 {
        background-color: var(--colour-accent-4);
      }
      
      .text-color-accent-1 {
        color: var(--color-accent-1);
      }
      
      .bg-color-accent-1 {
        background-color: var(--color-accent-1);
      }
      
      .text-color-accent-2 {
        color: var(--color-accent-2);
      }
      
      .bg-color-accent-2 {
        background-color: var(--color-accent-2);
      }
      
      .text-color-accent-3 {
        color: var(--color-accent-3);
      }
      
      .bg-color-accent-3 {
        background-color: var(--color-accent-3);
      }
      
      .text-color-accent-4 {
        color: var(--color-accent-4);
      }
      
      .bg-color-accent-4 {
        background-color: var(--color-accent-4);
      }

# check config to CSS end user function

    Code
      deckhand_config_to_css(write = FALSE)
    Output
      @import url('https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,500;1,500&display=swap');
      
      :root {
        --colour-headings: #0F36C7;
        --colour-body: #0C0C0C;
        --colour-primary: #0F36C7;
        --colour-dark-grey: #666666;
        --colour-dark-gray: #666666;
        --colour-light-grey: #CCCCCC;
        --colour-light-gray: #CCCCCC;
        --color-headings: #0F36C7;
        --color-body: #0C0C0C;
        --color-primary: #0F36C7;
        --color-dark-grey: #666666;
        --color-dark-gray: #666666;
        --color-light-grey: #CCCCCC;
        --color-light-gray: #CCCCCC;
        --color-white: #ffffff;
        --colour-accent-1: #40ADFE;
        --colour-accent-2: #FFEC1C;
        --colour-accent-3: #8AC755;
        --colour-accent-4: #FF144C;
        --color-accent-1: #40ADFE;
        --color-accent-2: #FFEC1C;
        --color-accent-3: #8AC755;
        --color-accent-4: #FF144C
      }
      
      h1, h2, h3, h4, h5, h6 {
        font-family: 'Open Sans', sans-serif;
        font-weight: 500;
        color: var(--colour-headings);
        margin: 0px;
        padding: 0px;
      }
      
      h1 {
        font-size: 24pt;
      }
      
      h2, h3, h4, h5, h6 {
        font-size: 10pt;
        margin-top: 6pt;
      }
      
      body, p {
        font-family: 'Georgia', serif;
        font-weight: 300;
        font-size: 10pt;
        color: var(--colour-body);
      }
      
      p {
        margin-bottom: 6pt;
      }
      
      .text-primary {
        color: var(--colour-primary);
      }
      
      .bg-primary {
        background-color: var(--colour-primary);
      }
      
      .text-light-grey {
        color: var(--colour-light-grey);
      }
      
      .bg-light-grey {
        background-color: var(--colour-light-grey);
      }
      
      .text-light-gray {
        color: var(--colour-light-gray);
      }
      
      .bg-light-gray {
        background-color: var(--colour-light-gray);
      }
      
      .text-dark-grey {
        color: var(--colour-dark-grey);
      }
      
      .bg-dark-grey {
        background-color: var(--colour-dark-grey);
      }
      
      .text-dark-gray {
        color: var(--colour-dark-gray);
      }
      
      .bg-dark-gray {
        background-color: var(--colour-dark-gray);
      }
      
      .text-white {
        color: var(--colour-white);
      }
      
      .bg-white {
        background-color: var(--colour-white);
      }
      
      .draft {
        border: 1px solid var(--colour-light-grey);
      }
      
      .text-colour-accent-1 {
        color: var(--colour-accent-1);
      }
      
      .bg-colour-accent-1 {
        background-color: var(--colour-accent-1);
      }
      
      .text-colour-accent-2 {
        color: var(--colour-accent-2);
      }
      
      .bg-colour-accent-2 {
        background-color: var(--colour-accent-2);
      }
      
      .text-colour-accent-3 {
        color: var(--colour-accent-3);
      }
      
      .bg-colour-accent-3 {
        background-color: var(--colour-accent-3);
      }
      
      .text-colour-accent-4 {
        color: var(--colour-accent-4);
      }
      
      .bg-colour-accent-4 {
        background-color: var(--colour-accent-4);
      }
      
      .text-color-accent-1 {
        color: var(--color-accent-1);
      }
      
      .bg-color-accent-1 {
        background-color: var(--color-accent-1);
      }
      
      .text-color-accent-2 {
        color: var(--color-accent-2);
      }
      
      .bg-color-accent-2 {
        background-color: var(--color-accent-2);
      }
      
      .text-color-accent-3 {
        color: var(--color-accent-3);
      }
      
      .bg-color-accent-3 {
        background-color: var(--color-accent-3);
      }
      
      .text-color-accent-4 {
        color: var(--color-accent-4);
      }
      
      .bg-color-accent-4 {
        background-color: var(--color-accent-4);
      }

---

    "@import url('https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,500;1,500&display=swap');\n\n:root {\n  --colour-headings: #0F36C7;\n  --colour-body: #0C0C0C;\n  --colour-primary: #0F36C7;\n  --colour-dark-grey: #666666;\n  --colour-dark-gray: #666666;\n  --colour-light-grey: #CCCCCC;\n  --colour-light-gray: #CCCCCC;\n  --color-headings: #0F36C7;\n  --color-body: #0C0C0C;\n  --color-primary: #0F36C7;\n  --color-dark-grey: #666666;\n  --color-dark-gray: #666666;\n  --color-light-grey: #CCCCCC;\n  --color-light-gray: #CCCCCC;\n  --color-white: #ffffff;\n  --colour-accent-1: #40ADFE;\n  --colour-accent-2: #FFEC1C;\n  --colour-accent-3: #8AC755;\n  --colour-accent-4: #FF144C;\n  --color-accent-1: #40ADFE;\n  --color-accent-2: #FFEC1C;\n  --color-accent-3: #8AC755;\n  --color-accent-4: #FF144C\n}\n\nh1, h2, h3, h4, h5, h6 {\n  font-family: 'Open Sans', sans-serif;\n  font-weight: 500;\n  color: var(--colour-headings);\n  margin: 0px;\n  padding: 0px;\n}\n\nh1 {\n  font-size: 24pt;\n}\n\nh2, h3, h4, h5, h6 {\n  font-size: 10pt;\n  margin-top: 6pt;\n}\n\nbody, p {\n  font-family: 'Georgia', serif;\n  font-weight: 300;\n  font-size: 10pt;\n  color: var(--colour-body);\n}\n\np {\n  margin-bottom: 6pt;\n}\n\n.text-primary {\n  color: var(--colour-primary);\n}\n\n.bg-primary {\n  background-color: var(--colour-primary);\n}\n\n.text-light-grey {\n  color: var(--colour-light-grey);\n}\n\n.bg-light-grey {\n  background-color: var(--colour-light-grey);\n}\n\n.text-light-gray {\n  color: var(--colour-light-gray);\n}\n\n.bg-light-gray {\n  background-color: var(--colour-light-gray);\n}\n\n.text-dark-grey {\n  color: var(--colour-dark-grey);\n}\n\n.bg-dark-grey {\n  background-color: var(--colour-dark-grey);\n}\n\n.text-dark-gray {\n  color: var(--colour-dark-gray);\n}\n\n.bg-dark-gray {\n  background-color: var(--colour-dark-gray);\n}\n\n.text-white {\n  color: var(--colour-white);\n}\n\n.bg-white {\n  background-color: var(--colour-white);\n}\n\n.draft {\n  border: 1px solid var(--colour-light-grey);\n}\n\n.text-colour-accent-1 {\n  color: var(--colour-accent-1);\n}\n\n.bg-colour-accent-1 {\n  background-color: var(--colour-accent-1);\n}\n\n.text-colour-accent-2 {\n  color: var(--colour-accent-2);\n}\n\n.bg-colour-accent-2 {\n  background-color: var(--colour-accent-2);\n}\n\n.text-colour-accent-3 {\n  color: var(--colour-accent-3);\n}\n\n.bg-colour-accent-3 {\n  background-color: var(--colour-accent-3);\n}\n\n.text-colour-accent-4 {\n  color: var(--colour-accent-4);\n}\n\n.bg-colour-accent-4 {\n  background-color: var(--colour-accent-4);\n}\n\n.text-color-accent-1 {\n  color: var(--color-accent-1);\n}\n\n.bg-color-accent-1 {\n  background-color: var(--color-accent-1);\n}\n\n.text-color-accent-2 {\n  color: var(--color-accent-2);\n}\n\n.bg-color-accent-2 {\n  background-color: var(--color-accent-2);\n}\n\n.text-color-accent-3 {\n  color: var(--color-accent-3);\n}\n\n.bg-color-accent-3 {\n  background-color: var(--color-accent-3);\n}\n\n.text-color-accent-4 {\n  color: var(--color-accent-4);\n}\n\n.bg-color-accent-4 {\n  background-color: var(--color-accent-4);\n}"

