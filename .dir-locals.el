(setq org-publish-project-alist
      '(("site-content"
     :html-preamble (concat "INSERT HTML CODE HERE FOR PREAMBLE")
     :html-postamble (concat "INSERT HTML CODE HERE FOR POSTAMBLE"))
    ("site" :components ("site-content"))))
(setq org-html-preamble "  <ul class='topcontent'>
    <li class='topitem'>uwu</li>
    <li class='topitem'><a href='meow.html'>meow</a></li>
    <li class='topitem'>uwu</li>
  </ul>
")

(setq org-html-head " <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-sacle=1'>
  <title>My website!!!</title>
  <!-- this is where we load css and js -->
  <link rel='stylesheet' href='meow.css'>
  <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
")


(defun my/org-html-headline-wrapper (orig-fun headline contents info)
  "If :HTML_LINK is set, wrap the whole outline container in <a>.
Otherwise, just return the default headline export."
  (let* ((link (org-element-property :HTML_LINK headline))
         (default (funcall orig-fun headline contents info)))
    (if link
        (format "<a href=\"%s\">%s</a>" link default)
      default)))

(advice-add 'org-html-headline :around #'my/org-html-headline-wrapper)

