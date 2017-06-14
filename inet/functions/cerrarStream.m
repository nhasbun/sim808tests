function res = cerrarStream(stream)
  fclose(stream);
  delete(stream);
end
