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
  "Customize headline export:
- If :HTML_LINK is set, wrap the entire outline <div> in <a>.
- If :HIDE_HEADING: t is set, remove the <hN> heading element."
  (let* ((link (org-element-property :HTML_LINK headline))
         (hide (org-element-property :HIDE_HEADING headline))
         (default (funcall orig-fun headline contents info)))
    ;; If hiding heading, strip out <hN>...</hN>
    (when hide
      (setq default (replace-regexp-in-string "<h[1-9][^>]*>.*?</h[1-9]>" "" default)))
    ;; If link provided, wrap the entire outline block
    (if link
        (format "<a href=\"%s\">%s</a>" link default)
      default)))

(advice-add 'org-html-headline :around #'my/org-html-headline-wrapper)
