import sys, re, json, urllib, os

if __name__ == "__main__":
    inp = sys.argv[1]
    outp = re.sub(r'^content', 'compiled-site', sys.argv[1])
    outp = re.sub(r'\.md$', '.html', outp)
    if re.findall(r'\/\.', inp):
        print 'skipping dotfile: ', inp
    else:
        if inp.endswith(".md"):
            print "building: ", inp
            extra_info = dict(
                title=inp.split("/")[-2],
                desc="some nerd's website",
                img="/static/img/favicon.ico",
                showTableOfContents="false"
            )
            if os.path.isfile(inp + ".info"):
                with open(inp + ".info") as f:
                    extra_info.update(json.loads(f.read()))
            with open("base-template.html") as f:
                template = f.read()
            with open(inp) as f:
                raw_content = f.read()
                quoted_body = urllib.quote(json.dumps(raw_content))
                content = template.format(
                    content=quoted_body,
                    raw_content=raw_content.replace("<", "&lt;").replace(">", "&gt"),
                    **extra_info
                )
        else:
            print "copying: ", inp
            with open(inp) as f:
                content = f.read()
        with open(outp, "wb") as f:
            f.write(content)
