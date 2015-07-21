import sys, re

if __name__ == "__main__":
    inp = sys.argv[1]
    outp = re.sub(r'^content', 'compiled-site', sys.argv[1])
    outp = re.sub(r'\.md$', '.html', outp)
    if re.findall(r'\/\.', inp):
        print 'skipping dotfile: ', inp
    else:
        print "building: ", inp
        with open("base-template.html") as f:
            template = f.read()
        with open(inp) as f:
            content = template.format(content=f.read())
        with open(outp, "wb") as f:
            f.write(content)
