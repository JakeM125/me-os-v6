local inspector = {open=nil}

function inspector.show(item,amt)
    inspector.open = {item=item,amount=amt}
end

function inspector.close()
    inspector.open=nil
end

return inspector