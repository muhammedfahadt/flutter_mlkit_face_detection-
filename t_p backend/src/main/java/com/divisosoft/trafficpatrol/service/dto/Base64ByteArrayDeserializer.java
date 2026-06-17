package com.divisosoft.trafficpatrol.service.dto;

import java.io.IOException;
import java.util.Base64;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

public class Base64ByteArrayDeserializer extends JsonDeserializer<byte[]>{

    @Override
    public byte[] deserialize(JsonParser arg0, DeserializationContext arg1) throws IOException, JacksonException {
        String base64String = arg0.getValueAsString();
        return Base64.getDecoder().decode(base64String);
    }
    
}
