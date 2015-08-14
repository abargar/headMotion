function rframe = saveFrame(fig)

f = getframe(fig);
[rframe, ~] = frame2im(f);
close(fig);
end